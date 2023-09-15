import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/bloc/card_details/card_details_bloc.dart';
import 'package:flutter_easy_card/components/card_details.dart';
import 'package:flutter_easy_card/components/share_button.dart';

import 'package:flutter_easy_card/theme.dart';
import 'package:go_router/go_router.dart';

class MyCardDetailsScreen extends StatefulWidget {
  const MyCardDetailsScreen(
      {super.key, required this.cardId, required this.cardDetailsBloc});
  final String cardId;
  final CardDetailsBloc cardDetailsBloc;

  @override
  State<MyCardDetailsScreen> createState() => _MyCardDetailsScreenState();
}

class _MyCardDetailsScreenState extends State<MyCardDetailsScreen> {
  @override
  void initState() {
    super.initState();
    widget.cardDetailsBloc.add(FetchCardDetails(widget.cardId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardDetailsBloc, CardDetailsState>(
      bloc: widget.cardDetailsBloc,
      builder: (context, state) {
        if (state is CardDetailsPending) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is CardDetailsFailure) {
          return const Center(
            child: Text('Load failed'),
          );
        }
        if (state is CardDetailsSuccess) {
          final cardDetails = state.cardDetail;
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            floatingActionButton: ShareButton(
                colorCode: cardDetails.colorTheme, cardId: widget.cardId),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 15),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: black,
                    size: 32,
                  ),
                  onPressed: () {
                    context.push("/home");
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    context.push('/home/edit-card/${widget.cardId}');
                  },
                  child: Text('Edit', style: customTextButton()),
                ),
              ],
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'My Card Details',
                    style: appTitleStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            body: CardDetails(cardDetails: cardDetails),
          );
        }
        return Container();
      },
    );
  }
}
