import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../const/consts.dart';
import '../../models/doctor_model.dart';
import '../../providers/doctor_provider.dart';

class DoctorCardWidget extends StatelessWidget {
  final Function onTap;
  final Doctor doctorModel;
  const DoctorCardWidget({
    super.key,
    required this.onTap,
    required this.doctorModel,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
      onTap: () {
        onTap();
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: BorderRadius.circular(Consts.DefaultBorderRadius),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(Consts.DefaultBorderRadius),
                      child: FutureBuilder(
                        future: context
                            .read<MockDoctorProvider>()
                            .getDoctorImage(doctorModel.imageUrl),
                        builder: (BuildContext context,
                            AsyncSnapshot<Uint8List?> snapshot) {
                          if (snapshot.connectionState ==
                                  ConnectionState.done &&
                              snapshot.hasData) {
                            return Image.network(
                              doctorModel.imageUrl,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(Icons.error_outline),
                                  Text('Unable to Load Image'),
                                ],
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.error_outline),
                                Text('Unable to Load Image'),
                              ],
                            );
                          }

                          return const CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        doctorModel.name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctorModel.specialization,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        doctorModel.hospital,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
