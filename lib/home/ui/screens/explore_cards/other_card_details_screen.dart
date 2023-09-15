import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easy_card/components/card_details.dart';
import 'package:flutter_easy_card/components/share_button.dart';
import 'package:flutter_easy_card/core/service/firebase_collection_service.dart';
import 'package:go_router/go_router.dart';

import 'package:flutter_easy_card/bloc/card_details/card_details_bloc.dart';
import 'package:flutter_easy_card/bloc/save_card/save_card_bloc.dart';
import 'package:flutter_easy_card/components/custom_action_icon_button.dart';
import 'package:flutter_easy_card/core/adapter/user_store.dart';
import 'package:flutter_easy_card/theme.dart';

class OtherCardDetailsScreen extends StatefulWidget {
  OtherCardDetailsScreen({
    super.key,
    required this.cardId,
    required this.cardDetailsBloc,
    required this.userStore,
    required this.firebaseCollectionService,
  }) : saveCardBloc = SaveCardBloc(
            userStore: userStore,
            firebaseCollectionService: firebaseCollectionService);
  final UserStore userStore;
  final FirebaseCollectionService firebaseCollectionService;
  final String cardId;
  final CardDetailsBloc cardDetailsBloc;
  final SaveCardBloc saveCardBloc;

  @override
  State<OtherCardDetailsScreen> createState() => _OtherCardDetailsScreenState();
}

class _OtherCardDetailsScreenState extends State<OtherCardDetailsScreen> {
  @override
  void initState() {
    super.initState();
    widget.cardDetailsBloc.add(FetchCardDetails(widget.cardId));
  }

  @override
  Widget build(BuildContext context) {
    String currentParentRoute =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

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
          bool isSaved = state.isSaved;
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: Colors.white,
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ShareButton(
                    colorCode: cardDetails.colorTheme, cardId: widget.cardId),
                const SizedBox(width: 10),
                BlocBuilder<SaveCardBloc, SaveCardState>(
                  bloc: widget.saveCardBloc,
                  builder: (context, state) {
                    if (state is SaveCardSuccess) {
                      isSaved = state.isSaved;
                    }
                    return SizedBox(
                      width: 65,
                      child: CustomActionIconButton(
                        onPressed: () {
                          widget.saveCardBloc
                              .add(SaveCard(cardId: widget.cardId));
                        },
                        icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                        color: Color(int.parse(cardDetails.colorTheme)),
                      ),
                    );
                  },
                )
              ],
            ),
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
                    if (currentParentRoute.startsWith('/explore-cards')) {
                      debugPrint(currentParentRoute);
                      context.push("/explore-cards");
                    }
                    if (currentParentRoute.startsWith('/saved-cards')) {
                      debugPrint(currentParentRoute);
                      context.push("/saved-cards");
                    }
                  },
                ),
              ),
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Card Details',
                    style: appTitleStyle,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            body: CardDetails(
              cardDetails: cardDetails,
            ),
          );
        }
        return Container();
      },
    );
  }
}
