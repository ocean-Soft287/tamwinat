import Flutter
import PassKit

public class ApplePayPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "apple_pay", binaryMessenger: registrar.messenger())
    let instance = ApplePayPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "startApplePay" {
      guard let args = call.arguments as? [String: Any],
            let merchantId = args["merchantId"] as? String else {
        result(FlutterError(code: "InvalidArgs", message: "Missing merchantId", details: nil))
        return
      }

      self.presentApplePay(merchantId: merchantId, result: result)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  private func presentApplePay(merchantId: String, result: @escaping FlutterResult) {
    let paymentNetworks: [PKPaymentNetwork] = [.visa, .masterCard, .amex]

    guard PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) else {
      result(FlutterError(code: "NotAvailable", message: "Apple Pay is not available", details: nil))
      return
    }

    let request = PKPaymentRequest()
    request.merchantIdentifier = merchantId
    request.supportedNetworks = paymentNetworks
    request.merchantCapabilities = .capability3DS
    request.countryCode = "KW"
    request.currencyCode = "KWD"

    // Example: $10 item
    let item = PKPaymentSummaryItem(label: "Example Item", amount: NSDecimalNumber(string: "10.00"))
    request.paymentSummaryItems = [item]

    guard let viewController = UIApplication.shared.delegate?.window??.rootViewController else {
      result(FlutterError(code: "NoViewController", message: "Could not find root view controller", details: nil))
      return
    }

    let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
    applePayController.delegate = self

    viewController.present(applePayController, animated: true)
  }
}

extension ApplePayPlugin: PKPaymentAuthorizationViewControllerDelegate {
  public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
    // Handle payment authorization
    completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
  }

  public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
    controller.dismiss(animated: true, completion: nil)
  }

  public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didFinishWith status: PKPaymentAuthorizationStatus, error: Error?) {
    controller.dismiss(animated: true, completion: nil)
  }
}