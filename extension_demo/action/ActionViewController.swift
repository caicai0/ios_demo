//
//  ActionViewController.swift
//  action
//
//  Created by 李玉峰 on 2018/4/23.
//  Copyright © 2018年 cai. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        var imageFound = false
        let types = [(kUTTypeItem as String),(kUTTypeContent as String),(kUTTypeCompositeContent as String),(kUTTypeMessage as String),(kUTTypeContact as String),(kUTTypeArchive as String),(kUTTypeDiskImage as String),(kUTTypeData as String),(kUTTypeDirectory as String),(kUTTypeResolvable as String),(kUTTypeSymLink as String),(kUTTypeExecutable as String),(kUTTypeMountPoint as String),(kUTTypeAliasFile as String),(kUTTypeAliasRecord as String),(kUTTypeURLBookmarkData as String),(kUTTypeURL as String),(kUTTypeFileURL as String),(kUTTypeText as String),(kUTTypePlainText as String),(kUTTypeUTF8PlainText as String),(kUTTypeUTF16ExternalPlainText as String),(kUTTypeUTF16PlainText as String),(kUTTypeDelimitedText as String),(kUTTypeCommaSeparatedText as String),(kUTTypeTabSeparatedText as String),(kUTTypeUTF8TabSeparatedText as String),(kUTTypeRTF as String),(kUTTypeHTML as String),(kUTTypeXML as String),(kUTTypeSourceCode as String),(kUTTypeAssemblyLanguageSource as String),(kUTTypeCSource as String),(kUTTypeObjectiveCSource as String),(kUTTypeSwiftSource as String),(kUTTypeCPlusPlusSource as String),(kUTTypeObjectiveCPlusPlusSource as String),(kUTTypeCHeader as String),(kUTTypeCPlusPlusHeader as String),(kUTTypeJavaSource as String),(kUTTypeScript as String),(kUTTypeAppleScript as String),(kUTTypeOSAScript as String),(kUTTypeOSAScriptBundle as String),(kUTTypeJavaScript as String),(kUTTypeShellScript as String),(kUTTypePerlScript as String),(kUTTypePythonScript as String),(kUTTypeRubyScript as String),(kUTTypePHPScript as String),(kUTTypeJSON as String),(kUTTypePropertyList as String),(kUTTypeXMLPropertyList as String),(kUTTypeBinaryPropertyList as String),(kUTTypePDF as String),(kUTTypeRTFD as String),(kUTTypeFlatRTFD as String),(kUTTypeTXNTextAndMultimediaData as String),(kUTTypeWebArchive as String),(kUTTypeImage as String),(kUTTypeJPEG as String),(kUTTypeJPEG2000 as String),(kUTTypeTIFF as String),(kUTTypePICT as String),(kUTTypeGIF as String),(kUTTypePNG as String),(kUTTypeQuickTimeImage as String),(kUTTypeAppleICNS as String),(kUTTypeBMP as String),(kUTTypeICO as String),(kUTTypeRawImage as String),(kUTTypeScalableVectorGraphics as String),(kUTTypeLivePhoto as String),(kUTTypeAudiovisualContent as String),(kUTTypeMovie as String),(kUTTypeVideo as String),(kUTTypeAudio as String),(kUTTypeQuickTimeMovie as String),(kUTTypeMPEG as String),(kUTTypeMPEG2Video as String),(kUTTypeMPEG2TransportStream as String),(kUTTypeMP3 as String),(kUTTypeMPEG4 as String),(kUTTypeMPEG4Audio as String),(kUTTypeAppleProtectedMPEG4Audio as String),(kUTTypeAppleProtectedMPEG4Video as String),(kUTTypeAVIMovie as String),(kUTTypeAudioInterchangeFileFormat as String),(kUTTypeWaveformAudio as String),(kUTTypeMIDIAudio as String),(kUTTypePlaylist as String),(kUTTypeM3UPlaylist as String),(kUTTypeFolder as String),(kUTTypeVolume as String),(kUTTypePackage as String),(kUTTypeBundle as String),(kUTTypePluginBundle as String),(kUTTypeSpotlightImporter as String),(kUTTypeQuickLookGenerator as String),(kUTTypeXPCService as String),(kUTTypeFramework as String),(kUTTypeApplication as String),(kUTTypeApplicationBundle as String),(kUTTypeApplicationFile as String),(kUTTypeUnixExecutable as String),(kUTTypeWindowsExecutable as String),(kUTTypeJavaClass as String),(kUTTypeJavaArchive as String),(kUTTypeSystemPreferencesPane as String),(kUTTypeGNUZipArchive as String),(kUTTypeBzip2Archive as String),(kUTTypeZipArchive as String),(kUTTypeSpreadsheet as String),(kUTTypePresentation as String),(kUTTypeDatabase as String),(kUTTypeVCard as String),(kUTTypeToDoItem as String),(kUTTypeCalendarEvent as String),(kUTTypeEmailMessage as String),(kUTTypeInternetLocation as String),(kUTTypeInkText as String),(kUTTypeFont as String),(kUTTypeBookmark as String),(kUTType3DContent as String),(kUTTypePKCS12 as String),(kUTTypeX509Certificate as String),(kUTTypeElectronicPublication as String),(kUTTypeLog as String)]
        
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                for type in types {
                    if provider.hasItemConformingToTypeIdentifier(type) {
                        provider.loadItem(forTypeIdentifier: type, options: nil) { (url, error) in
                            print(type, url ?? "X",error)
                        }
                    }
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func done() {
        // Return any edited content to the host app.
        // This template doesn't do anything, so we just echo the passed in items.
        self.extensionContext!.completeRequest(returningItems: self.extensionContext!.inputItems, completionHandler: nil)
    }

}
