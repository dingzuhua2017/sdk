import 'package:polkawallet_sdk/api/api.dart';
import 'package:polkawallet_sdk/service/uos.dart';

/// Steps to complete offline-signature as a cold-wallet:
/// 1. parseQrCode: parse raw data of QR code, and get signer address from it.
/// 2. signAsync: sign the extrinsic with password, get signature.
/// 3. addSignatureAndSend: send tx with address of step1 & signature of step2.
///
/// Support offline-signature as a hot-wallet: makeQrCode
class ApiUOS {
  ApiUOS(this.apiRoot, this.service);

  final PolkawalletApi apiRoot;
  final ServiceUOS service;

  /// parse data of QR code.
  /// @return: signer pubKey [String]
  Future<String> parseQrCode(String data) async {
    final res = await service.parseQrCode(data);
    return res;
  }

  /// this function must be called after parseQrCode.
  /// @return: signature [String]
  Future<String> signAsync(String password) async {
    final res = await service.signAsync(password);
    return res;
  }

  /// [onStatusChange] is a callback when tx status change.
  /// @return txHash [string] if tx finalized success.
  Future<Map> addSignatureAndSend(
    String address,
    signed,
    Function(String) onStatusChange,
  ) async {
    final res = service.addSignatureAndSend(
      address,
      signed,
      onStatusChange ?? (status) => print(status),
    );
    return res;
  }

  // Future<Map> makeQrCode(Map txInfo, List params, {String rawParam}) async {
  //   String param = rawParam != null ? rawParam : jsonEncode(params);
  //   final Map res = await apiRoot.evalJavascript(
  //     'account.makeTx(${jsonEncode(txInfo)}, $param)',
  //     allowRepeat: true,
  //   );
  //   return res;
  // }

}
