//
//  ViewController.m
//  fmdb
//
//  Created by 李玉峰 on 2018/2/9.
//  Copyright © 2018年 李玉峰. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

@property (nonatomic, strong)NSString * docPath;
@property (nonatomic, strong)NSString * dbPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    self.dbPath = [NSString stringWithFormat:@"%@/db.sqlite",self.docPath];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self testDb2];
    });
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)insertIntoTablePerson:(FMDatabase *)db arguments:(NSDictionary *)arguments {
    BOOL success = [db executeUpdate:@"INSERT INTO person (identifier, name, age) VALUES (:identifier, :name, :age)"
             withParameterDictionary:arguments];
    
    if (!success) {
        NSLog(@"error = %@", [db lastErrorMessage]);
    }
    return success;
}

- (void)testDb2{
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    FMDatabaseQueue *fqueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
    [fqueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"drop table person"];
        if([db executeUpdate:@"create table person (identifier integer primary key autoincrement, name text, age integer)"]){
            NSLog(@"Demon 插入成功 - %@", [NSThread currentThread]);
        }
        [db close];
    }];

    dispatch_group_async(group, queue, ^{
//        FMDatabaseQueue *fqueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
        NSLog(@"start");
        for (NSInteger i=0; i<1000; i++) {
            [fqueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
                if ([db executeUpdate:@"INSERT INTO person VALUES (?, ?, ?)", @(i+5), @"Jemmy", @(i)]) {
                    NSLog(@"Jemmy 插入成功 - %@", [NSThread currentThread]);
                }else{
                    *rollback = true;
                }
            }];
        }
        NSLog(@"end");
//        NSLog(@"start");
//        for (NSInteger i=0; i<1000; i++) {
//            [fqueue inDatabase:^(FMDatabase * _Nonnull db) {
//                if ([db executeUpdate:@"INSERT INTO person VALUES (?, ?, ?)", @(i+5), @"Jemmy", @(i)]) {
//                    NSLog(@"Jemmy 插入成功 - %@", [NSThread currentThread]);
//                }
//            }];
//        }
//        NSLog(@"end");
        
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"完成 - %@", [NSThread currentThread]);
        [fqueue inDatabase:^(FMDatabase * _Nonnull db) {
            FMResultSet *s = [db executeQuery:@"SELECT * FROM person"];
            while ([s next]) {
                int identifier = [s intForColumnIndex:0];
                NSString *name = [s stringForColumnIndex:1];
                int age = [s intForColumnIndex:2];
                NSLog(@"identifier=%d, name=%@, age=%d", identifier, name, age);
            }
            [db close];
        }];

    });
}


@end
