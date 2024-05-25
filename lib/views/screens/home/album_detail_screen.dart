import 'package:ajira_social/common/constants.dart';
import 'package:ajira_social/modals/album_modal.dart';
import 'package:ajira_social/theme/theme_manager.dart';
import 'package:ajira_social/views/components/body_widget.dart';
import 'package:ajira_social/views/screens/home/bloc/album_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlbumDetailScreen extends StatelessWidget {
  const AlbumDetailScreen({
    this.albumModal,
    super.key,
  });

  final AlbumModal? albumModal; // Album modal instance, can be null

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumBloc, AlbumState>(
      bloc: context.read<AlbumBloc>()
        ..add(
          GetAlbumPhotoDetailEvent(
            id: albumModal!.id,
          ),
        ),
      builder: (context, albumState) {
        return BodyWidget(
          isLoading: albumState.status == AlbumStatus.loading,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                albumModal!.title.toString(),
              ), // Display album title in app bar
              centerTitle: true,
            ),
            body: ListView.builder(
              itemCount: albumState.photosModal?.length ?? 0,
              itemBuilder: (context, index) {
                final album = albumState.photosModal?[index];
                return Padding(
                  padding: horizontalPadding8 + verticalPadding8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: context.secondaryContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: horizontalPadding8 + verticalPadding8,
                      child: Column(
                        children: [
                          // Display image or loading indicator if the URL is null or empty
                          if (album!.url == null && album.url!.isEmpty)
                            const CircularProgressIndicator()
                          else
                            Image.network(
                              fit: BoxFit.fitWidth,
                              album.url ?? '',
                            ),

                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: (album.thumbnailUrl == null &&
                                    album.thumbnailUrl!.isEmpty)
                                ? null
                                : Image.network(
                                    album.thumbnailUrl ?? '',
                                  ),
                            title: Text(
                              album.title ?? '',
                              style: context.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
