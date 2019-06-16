// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Raw data for the animation demo.

import 'package:flutter/material.dart';

const Color _mariner = const Color(0xFF3B5F8F);
const Color _mediumPurple = const Color(0xFF8266D4);
const Color _tomato = const Color(0xFFF95B57);
const Color _mySin = const Color(0xFFF3A646);

class SectionDetail {
  const SectionDetail({this.title, this.subtitle, this.imageAsset, this.url});
  final String title;
  final String url;
  final String subtitle;
  final String imageAsset;
}

class Section {
  const Section({
    this.title,
    this.backgroundAsset,
    this.leftColor,
    this.rightColor,
    this.details,
  });
  final String title;
  final String backgroundAsset;
  final Color leftColor;
  final Color rightColor;
  final List<SectionDetail> details;

  @override
  bool operator ==(Object other) {
    if (other is! Section) return false;
    final Section otherSection = other;
    return title == otherSection.title;
  }

  @override
  int get hashCode => title.hashCode;
}

// TODO(hansmuller): replace the SectionDetail images and text. Get rid of
// the const vars like _eyeglassesDetail and insert a variety of titles and
// image SectionDetails in the allSections list.

SectionDetail _googleDetail(String url, String text, String sub) {
  return SectionDetail(
    imageAsset: 'assets/image/google.jpg',
    title: text,
    subtitle: sub,
    url: url,
  );
}

// const SectionDetail _googleImageDetail = const SectionDetail(
//   imageAsset: 'assets/image/fwatch.jpg',
// );

SectionDetail _facebookDetail(String url, String text, String sub) {
  return SectionDetail(
      imageAsset: 'assets/image/inss2.jpg',
      title: text,
      subtitle: sub,
      url: url);
}

const SectionDetail _facebookImageDetail = const SectionDetail(
  imageAsset: 'assets/image/inss2.jpg',
);

const SectionDetail _googleImageDetail = const SectionDetail(
  imageAsset: 'assets/image/enem2.jpg',
);

const SectionDetail _instagramDetail = const SectionDetail(
    imageAsset: 'assets/image/viagem2.jpg',
    title: 'Personal data on instagram',
    subtitle: 'click  here  ',
    url: 'https://www.instagram.com/download/request/');

const SectionDetail _instagramImageDetail = const SectionDetail(
  imageAsset: 'assets/image/viagem2.jpg',
);

const SectionDetail _twitterDetail = const SectionDetail(
    imageAsset: 'assets/image/detran2.jpg',
    title: 'See the data twitter keeps',
    subtitle: 'click  here',
    url: 'https://twitter.com/settings/your_twitter_data');

const SectionDetail _twitterImageDetail = const SectionDetail(
  imageAsset: 'assets/image/detran2.jpg',
);

final List<Section> allSections = <Section>[
  Section(
    title: 'ENEM',
    leftColor: _mediumPurple,
    rightColor: _mariner,
    backgroundAsset: 'assets/image/enem.png',
    details: <SectionDetail>[
      _googleImageDetail,
      _googleDetail("https://adssettings.google.com/authenticated",
          "O Exame Nacional do Ensino Médio (Enem) avalia o desempenho do estudante e colabora para:\n - Autoavaliação \n - Acesso à Educação Superior: Sisu | Prouni | Instituições Portuguesas \n - Acesso a financiamento e apoio estudantil: Fies | Prouni \n - Desenvolvimento de estudos e indicadores educacionais", "INSCREVER")
    ],
  ),
  Section(
    title: 'INSS',
    leftColor: _tomato,
    rightColor: _mediumPurple,
    backgroundAsset: 'assets/image/inss.png',
    details: <SectionDetail>[
      _facebookImageDetail,
      _facebookDetail('https://www.facebook.com/your_information/',
          'Facebook knows what are you doing', 'Check  your activity'),
      _facebookDetail(
          'https://www.facebook.com/dyi/?x=AdkU_sowbKQxwuhG&referrer=yfi_settings',
          'Download  your private data ',
          'your  post, like, comment till now'),
      _facebookDetail(
          'https://www.facebook.com/settings?tab=your_facebook_information',
          'What have you done so far in facebook?',
          'check it out'),
    ],
  ),
  const Section(
    title: 'PASSAPORTE',
    leftColor: _mySin,
    rightColor: _tomato,
    backgroundAsset: 'assets/image/pf.png',
    details: const <SectionDetail>[
      _instagramImageDetail,
      _instagramDetail,
    ],
  ),
  const Section(
    title: 'CNH',
    leftColor: _mariner,
    rightColor: _tomato,
    backgroundAsset: 'assets/image/detran.jpeg',
    details: const <SectionDetail>[
      _twitterImageDetail,
      _twitterDetail,
    ],
  ),
];
