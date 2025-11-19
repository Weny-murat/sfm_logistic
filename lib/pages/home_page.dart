import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sfm_logistic/pages/widgets/page_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SFM ERP'), centerTitle: true),
      body: SafeArea(
        child: Platform.isAndroid
            ? Column(
                children: [
                  PageCard(
                    path: '/l_list',
                    label: 'Yeni Yükleme',
                    icon: Icons.document_scanner,
                  ),
                  PageCard(
                    path: '/l_lists',
                    label: 'Yükleme Listeleri',
                    icon: Icons.list,
                  ),
                ],
              )
            : Column(
                children: [
                  PageCard(
                    path: '/l_list',
                    label: 'Yeni Yükleme',
                    icon: Icons.document_scanner,
                  ),
                  PageCard(
                    path: '/l_lists',
                    label: 'Yükleme Listeleri',
                    icon: Icons.list,
                  ),
                  PageCard(
                    path: '/archived_lists',
                    label: 'Arşivlenmiş Listeler',
                    icon: Icons.archive,
                  ),
                ],
              ),
      ),
    );
  }
}
