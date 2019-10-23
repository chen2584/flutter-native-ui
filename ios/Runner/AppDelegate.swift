import UIKit
import Flutter
import WebKit
import PDFKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
        ) -> Bool {
        let nativeViewFactory = FluffViewFactory()
        let pdfViewFactory = QPdfViewFactory()
        
        let plugin = registrar(forPlugin: "Runner")
        
        plugin.register(nativeViewFactory, withId: "FluffView")
        plugin.register(pdfViewFactory, withId: "PdfView")
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}

public class QPdfViewFactory: NSObject, FlutterPlatformViewFactory {
    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
        ) -> FlutterPlatformView {
        
        return QPdfView(frame, viewId: viewId, args: args)
    }

    public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

public class QPdfView: NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    let parameter: Dictionary<String, Any>
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
        self.parameter = args as! Dictionary<String, Any>
    }
    public func view() -> UIView {
//        let url = URL(string: "http://www.africau.edu/images/default/sample.pdf")
        let fileUrl = parameter["path"] as! String
        let url = URL(fileURLWithPath: fileUrl)
        let pdfView = PDFView()
        let document = PDFDocument(url: url)
        pdfView.document = document

        pdfView.translatesAutoresizingMaskIntoConstraints = false
        return pdfView
    }
}
