import 'package:resident/core/extension/size_extension.dart';


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:resident/app_package/core_package.dart';
import 'package:resident/app_package/domain/entity_package.dart';
import 'package:resident/app_package/presentation/bloc_package.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class DocumentBottomSheet extends StatefulWidget {
  final Document document;
  final AppLocalizations appLocalizations;

  const DocumentBottomSheet({required this.document,required this.appLocalizations, Key? key})
      : super(key: key);

  @override
  State<DocumentBottomSheet> createState() => _DocumentBottomSheetState();
}

class _DocumentBottomSheetState extends State<DocumentBottomSheet> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          width: AppConfig.screenWidth(context),
          height: AppConfig.screenHeight(context) * 0.9,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset('assets/icons/modal_bottom_top_line.svg'),
                AppDimension.verticalSize_16,
                Text(
                  widget.document.message?.translate(context.read<LanguageCubit>().languageCode()) ?? '',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        fontSize: 17.sf(context),
                        color: AppColor.c4000,
                      ),
                ),
                AppDimension.verticalSize_24,
                Text(
                  widget.document.content?.translate(context.read<LanguageCubit>().languageCode()) ?? '',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontSize: 14.sf(context),
                        color: AppColor.c3000,
                      ),
                ),
                AppDimension.verticalSize_16,
                GestureDetector(
                  onTap: (){
                    var url = widget.document.imageFile!.path!;
                    if(url.contains("pdf")) {
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => PDFViewerFromUrl(
                            url: url,
                          ),
                        ),
                      );
                    }
                    else if(url.contains("jpg")||url.contains("jpeg")||url.contains("png")){
                      Navigator.push(
                        context,
                        MaterialPageRoute<dynamic>(
                          builder: (_) => ImageViewerFromUrl(
                            url: url,
                          ),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      border: Border.all(color: Colors.blue,width: 2
                    ),
                  ),
                    child: Center(
                      child: Text(widget.appLocalizations.open.toUpperCase(),style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        color: Colors.blue,
                        fontSize: 14.sf(context),
                      ),),
                    ),
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(widget.appLocalizations.close.toUpperCase(),style: TextStyle(fontSize: 14.sf(context)))),
                AppDimension.verticalSize_16,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PDFViewerFromUrl extends StatelessWidget {
  const PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: const PDF().cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
class ImageViewerFromUrl extends StatelessWidget {
  const ImageViewerFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CachedNetworkImage(
     imageUrl:   url,

            placeholder: (context, url) => const CircularProgressIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}


