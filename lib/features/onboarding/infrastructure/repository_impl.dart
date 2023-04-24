// import 'package:core/core.dart';
// import 'package:mosaic_app/feature_rp/faq/faq.dart';

// class SampleImpl implements Sample {
//   final MosaicClient mosaicClient;
//   SampleImpl({required this.mosaicClient});
//   @override
//   Future<List<FAQModel>> getFAQList() async {
//     List<FAQModel> list = [];
//     try {
//       AppResponse<FAQModel> response = await mosaicClient.getFaqList();
//       if (response.apiResponse == APIResponse.success) {
//         list = response.dataAsList!;
//       }
//     } catch (e) {
//       throw UnimplementedError();
//     }
//     return list;
//   }
// }
