part of 'edit_card_bloc.dart';

sealed class EditCardEvent extends Equatable {
  const EditCardEvent();

  @override
  List<Object> get props => [];
}

class EditCard extends EditCardEvent {
  final CardModel cardData;
  final File? imageFile;

  const EditCard({
    required this.cardData,
    this.imageFile,
  });
}