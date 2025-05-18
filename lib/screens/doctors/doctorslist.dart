import 'package:Care4Her/screens/doctors/doctor.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../models/doctor_model.dart';
import '../../providers/doctor_provider.dart';
import '../../utils/exception_hander.dart';
import '../../utils/utils.dart';
import '../../widget/emptywidget.dart';
import '../../widget/errorwidget.dart';
import '../../widget/responsivegridview.dart';
import 'doctorcard.dart';
import 'doctorlistshimmer.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    return Consumer<MockDoctorProvider>(
      builder: (context, doctorProvider, child) {
        var doctorLocations = getAllDoctorLocations(
          doctorlist: doctorProvider.doctors,
        );
        List<Doctor> filteredDoctorList = getFilteredDoctor(
          doctorlist: doctorProvider.doctors,
          searchQuery: doctorProvider.filteredDoctors.isEmpty
              ? []
              : doctorLocations
                  .where((location) => doctorProvider.filteredDoctors.any(
                      (doctor) =>
                          doctor.location.toLowerCase() ==
                          location.toLowerCase()))
                  .toList(),
        );
        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context)!.doctors,
            ),
            actions: [
              doctorLocations.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        Utils(context).showCustomDialog(
                          child: _doctorFilterWidget(
                            context: context,
                            doctorLocations: doctorLocations,
                            doctorProvider: doctorProvider,
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.filter_list,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
          body: filteredDoctorList.isNotEmpty
              ? SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ResponsiveGridView(
                      itemCount: filteredDoctorList.length,
                      itemBuilder: (context, index) {
                        var doctorData = filteredDoctorList[index];
                        return DoctorCardWidget(
                          doctorModel: doctorData,
                          onTap: () async {
                            await Utils(context).push(
                              widget: DoctorDetail(
                                doctor: doctorData,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              : doctorProvider.isLoading
                  ? const DoctorsListShimmer()
                  : FutureBuilder<void>(
                          future: doctorProvider.fetchDoctors(),
                          builder: (context, snapshot) {
                        if (doctorProvider.doctors.isNotEmpty) {
                          List<Doctor> doctors = doctorProvider.doctors;

                          if (doctors.isEmpty) {
                            return EmptyWidget(
                              onRefresh: () => doctorProvider.fetchDoctors(),
                              viewPadding: viewPadding,
                              size: size,
                              svgAsset: 'assets/images/doctor.svg',
                              message:
                                  AppLocalizations.of(context)!.nodoctorfound,
                            );
                          }

                          return RefreshIndicator(
                            color: Theme.of(context).primaryColor,
                            onRefresh: () => doctorProvider.fetchDoctors(),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ResponsiveGridView(
                                  itemCount: doctors.length,
                                  itemBuilder: (context, index) {
                                    var doctorData = doctors[index];
                                    return DoctorCardWidget(
                                      doctorModel: doctorData,
                                      onTap: () async {
                                        await Utils(context).push(
                                          widget: DoctorDetail(
                                            doctor: doctorData,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }

                        if (doctorProvider.errorMessage.isNotEmpty) {
                          var error = ErrorModel(
                            url: "error",
                            message: doctorProvider.errorMessage,
                          );

                          return CustomErrorWidget(
                            onRefresh: () => doctorProvider.fetchDoctors(),
                            svgAsset: error.url,
                            message: error.message,
                            size: size,
                            viewPadding: viewPadding,
                          );
                        }

                        return const DoctorsListShimmer();
                      },
                    ),
        );
      },
    );
  }

  List<Doctor> getFilteredDoctor({
    required List<String> searchQuery,
    required List<Doctor> doctorlist,
  }) {
    if (searchQuery.isEmpty) return doctorlist;

    return doctorlist.where((doctor) {
      final doctorLocation = doctor.location.toString().toLowerCase();
      return searchQuery
          .any((query) => doctorLocation.contains(query.toLowerCase()));
    }).toList();
  }

  List<String> getAllDoctorLocations({
    required List<Doctor> doctorlist,
  }) {
    Set<String> uniqueLocations = <String>{};
    for (Doctor doctor in doctorlist) {
      uniqueLocations.add(doctor.location);
    }
    List<String> doctorLocations = uniqueLocations.toList()..sort();
    return doctorLocations;
  }

  Widget _doctorFilterWidget({
    required BuildContext context,
    required List<String> doctorLocations,
    required MockDoctorProvider doctorProvider,
  }) {
    final formKey = GlobalKey<FormState>();
    List<String> selectedLocations = doctorLocations
        .where((location) => doctorProvider.filteredDoctors.any((doctor) =>
            doctor.location.toLowerCase() == location.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppLocalizations.of(context)!.filterDoctorList,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Text(
                  AppLocalizations.of(context)!.locations,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      child: FormField<List<String>>(
                        autovalidateMode: AutovalidateMode.always,
                        initialValue: selectedLocations,
                        onSaved: (val) {
                          if (val != null && val.isNotEmpty) {
                            doctorProvider.filterByLocation(val);
                          }
                        },
                        validator: (value) {
                          if (value?.isEmpty ?? value == null) {
                            return AppLocalizations.of(context)!
                                .filterDoctorListError;
                          }
                          return null;
                        },
                        builder: (state) {
                          return Column(
                            children: [
                              ChipsChoice<String>.multiple(
                                value: state.value ?? [],
                                onChanged: (val) => state.didChange(val),
                                choiceItems: C2Choice.listFrom<String, String>(
                                  source: doctorLocations,
                                  value: (index, value) => value.toLowerCase(),
                                  label: (index, value) => value,
                                  tooltip: (index, value) => value,
                                ),
                                choiceStyle: C2ChipStyle.outlined(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .color,
                                  borderWidth: 2,
                                  selectedStyle: C2ChipStyle(
                                    borderColor: Theme.of(context).primaryColor,
                                    foregroundColor:
                                        Theme.of(context).primaryColor,
                                  ),
                                ),
                                wrapped: true,
                              ),
                              if (state.hasError)
                                Text(
                                  state.errorText!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.applybutton,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: ElevatedButton(
                            onPressed: () {
                              doctorProvider.resetFilters();
                              formKey.currentState!.reset();
                              Navigator.pop(context);
                            },
                            child: Text(
                                AppLocalizations.of(context)!.resetbutton,
                                textAlign: TextAlign.center),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
