import 'package:flutter/material.dart';
import 'package:reactive_dropdown_search/reactive_dropdown_search.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:sfm_logistic/data/models/customer.dart';
import 'package:sfm_logistic/pages/widgets/card_wrapper.dart';

class FirstStep extends StatelessWidget {
  const FirstStep({super.key, required this.customerList});

  final List<Customer> customerList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 4,
        children: [
          CardWrapper(
            child: ReactiveDropdownSearch<Customer, Customer>(
              formControlName: 'customer',
              items: (filter, loadProps) => customerList,
              itemAsString: (item) => item.name,
              compareFn: (item1, item2) => item1.id == item2.id,
              // filterFn: (item, filter) {
              //   final itemName = item.name.toLowerCase();
              //   final searchTerm = filter.toLowerCase();
              //   return itemName.contains(searchTerm);
              // },
              popupProps: PopupProps.menu(
                showSearchBox: true,

                emptyBuilder: (context, searchEntry) =>
                    Center(child: Text('Liste boş')),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                decoration: InputDecoration(
                  labelText: "Firma",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          CardWrapper(
            child: ReactiveDatePicker<DateTime>(
              formControlName: 'date',
              firstDate: DateTime(1985),
              lastDate: DateTime(2030),
              initialDate: DateTime.now(),
              builder: (context, picker, child) {
                return ReactiveTextField(
                  formControlName: 'date',
                  readOnly: true,
                  onTap: (control) {
                    picker.showPicker();
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.calendar_month),
                    label: Text('Tarih'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),
          ),

          CardWrapper(
            child: ReactiveTextField(
              formControlName: 'deliverer',
              showErrors: (control) => false,
              onChanged: (control) {
                if (control.value != null) {
                  control.value = (control.value as String).toUpperCase();
                }
              },
              decoration: InputDecoration(
                label: Text('Teslim Eden'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          CardWrapper(
            child: ReactiveTextField(
              formControlName: 'receiver',
              onChanged: (control) {
                if (control.value != null) {
                  control.value = (control.value as String).toUpperCase();
                }
              },
              decoration: InputDecoration(
                label: Text('Teslim Alan'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          CardWrapper(
            isExtended: true,
            child: ReactiveTextField(
              formControlName: 'note',
              maxLines: 5,
              decoration: InputDecoration(
                label: Text('Not'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          CardWrapper(
            child: ReactiveTextField(
              formControlName: 'plate',
              onChanged: (control) {
                if (control.value != null) {
                  control.value = (control.value as String).toUpperCase();
                }
              },
              showErrors: (control) => false,
              decoration: InputDecoration(
                label: Text('Plaka'),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          ReactiveFormConsumer(
            builder: (context, form, child) {
              final isCustom = form.control('isCustom').value == true;
              return Visibility(
                visible: isCustom,
                child: Column(
                  children: [
                    CardWrapper(
                      child: ReactiveTextField(
                        formControlName: 'name',
                        onChanged: (control) {
                          if (control.value != null) {
                            control.value = (control.value as String)
                                .toUpperCase();
                          }
                        },
                        showErrors: (control) => false,
                        decoration: InputDecoration(
                          label: Text('Şoför Ad Soyad'),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    CardWrapper(
                      child: ReactiveTextField(
                        formControlName: 'tc',
                        onChanged: (control) {
                          if (control.value != null) {
                            control.value = (control.value as String)
                                .toUpperCase();
                          }
                        },
                        showErrors: (control) => false,
                        decoration: InputDecoration(
                          label: Text('TC Kimlik No'),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    CardWrapper(
                      child: ReactiveTextField(
                        formControlName: 'tel',
                        onChanged: (control) {
                          if (control.value != null) {
                            control.value = (control.value as String)
                                .toUpperCase();
                          }
                        },
                        showErrors: (control) => false,
                        decoration: InputDecoration(
                          label: Text('Telefon Numarası'),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
