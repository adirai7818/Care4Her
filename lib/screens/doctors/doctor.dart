import 'package:Care4Her/models/doctor_model.dart';
import 'package:Care4Her/providers/doctor_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../const/consts.dart';
import '../../providers/languageprovider.dart';
import '../../utils/utils.dart';

class DoctorDetail extends StatelessWidget {
  final Doctor doctor;
  const DoctorDetail({
    super.key,
    required this.doctor,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageProvider>().languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          doctor.name,
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: constraints.maxWidth - 100,
                  height: constraints.maxWidth - 100,
                  child: ClipRRect(
                    borderRadius:
                        BorderRadius.circular(Consts.DefaultBorderRadius),
                    child: FutureBuilder(
                      future: context
                          .watch<MockDoctorProvider>()
                          .getDoctorImage(doctor.imageUrl),
                      builder: (BuildContext context,
                          AsyncSnapshot<Uint8List?> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done &&
                            snapshot.hasData) {
                          return Image.network(
                            doctor.imageUrl,
                            fit: BoxFit.fill,
                          );
                        }

                        if (snapshot.hasError) {
                          return const SizedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline),
                                Text('Unable to Load Image'),
                              ],
                            ),
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  doctor.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    // '${doctor.speciality[locale]} ${AppLocalizations.of(context)!.specialist}',
                    doctor.specialization,
                    textAlign: TextAlign.center,
                  ),
                ),
                // const SizedBox(
                //   height: 5,
                // ),
               
                // const SizedBox(
                //   height: 20,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(
                                  Consts.DefaultBorderRadius)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Text(AppLocalizations.of(context)!.experience),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                    '${doctor.experience}+ ${AppLocalizations.of(context)!.years}'
                                    ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).primaryColor),
                              borderRadius: BorderRadius.circular(
                                  Consts.DefaultBorderRadius)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: [
                                Text(AppLocalizations.of(context)!.rating),
                                const SizedBox(
                                  height: 5,
                                ),
                                RatingBarIndicator(
                                  itemSize: 20,
                                  rating: doctor.rating,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Text(
                  AppLocalizations.of(context)!.biography,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                // const SizedBox(
                //   height: 10,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReadMoreText(
                    doctor.description,
                    trimLines: 5,
                    colorClickableText: Colors.red,
                    // trimMode: TrimMode.Line,
                    trimMode: TrimMode.Length,

                    trimCollapsedText: AppLocalizations.of(context)!.readmore,
                    trimExpandedText: AppLocalizations.of(context)!.readless,
                    moreStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                    lessStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor),
                  ),
                ),
                Card(
                  child: InkWell(
                    onTap: () => _makePhoneCall(doctor.phone),
                    borderRadius:
                        BorderRadius.circular(Consts.DefaultBorderRadius),
                    child: ListTile(
                      title: Text(
                        AppLocalizations.of(context)!.callforappointmentbutton,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}
