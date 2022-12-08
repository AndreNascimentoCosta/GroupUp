import 'package:flutter/material.dart';
import 'package:groupup/screens/group/components/chart/chart.dart';

class IndividualGroup {
  final String name, image, rank, value, expand;
  final Widget chart;
  
  IndividualGroup({
    required this.name,
    required this.image,
    required this.rank,
    required this.value,
    required this.expand,
    required this.chart,
  });
}

List individualGroupData = [
  IndividualGroup(
    name: "Harmony Cope",
    image: "assets/images/user_individual_group_1.png",
    rank: "1°",
    value: "12.3",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
  IndividualGroup(
    name: "Sledge Hammer",
    image: "assets/images/user_individual_group_2.png",
    rank: "2°",
    value: "10.5",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
  IndividualGroup(
    name: "Me",
    image: "assets/images/user_individual_group_3.png",
    rank: "3°",
    value: "10.2",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
  IndividualGroup(
    name: "Devon Miles",
    image: "assets/images/user_individual_group_4.png",
    rank: "4°",
    value: "9.7",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
  IndividualGroup(
    name: "Kate Tanner",
    image: "assets/images/user_individual_group_5.png",
    rank: "5°",
    value: "9.2",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
  IndividualGroup(
    name: "Angela Bower",
    image: "assets/images/user_individual_group_6.png",
    rank: "6°",
    value: "8.2",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
  IndividualGroup(
    name: "Peter Thornton",
    image: "assets/images/user_individual_group_7.png",
    rank: "7°",
    value: "7.3",
      expand: "assets/icons/arrow_down.png",
      chart: const Chart(),
  ),
  IndividualGroup(
    name: "Jonathan Higg...",
    image: "assets/images/user_individual_group_8.png",
    rank: "8°",
    value: "6.4",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
  IndividualGroup(
    name: "Angus MacGyv...",
    image: "assets/images/user_individual_group_9.png",
    rank: "9°",
    value: "5.8",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
  IndividualGroup(
    name: "Alfredo Westerv...",
    image: "assets/images/user_individual_group_10.png",
    rank: "10°",
    value: "5.8",
    expand: "assets/icons/arrow_down.png",
    chart: const Chart(),
  ),
];