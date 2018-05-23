var Action = function() {};

Action.prototype = {
    
run: function(arguments) {
    
    var imgs = document.getElementsByTagName("img");
    var imgUrls = [];
    for (var i = 0; i < imgs.length; i++)
    {
        if (imgs[i].src != null && imgs[i].src.indexOf("http") == 0)
        {
            imgUrls.push(imgs[i].src);
        }
    }
    
    arguments.completionFunction({"imgs" : imgUrls});
},
    
finalize: function(arguments) {
    
}
    
};

var ExtensionPreprocessingJS = new Action
