// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:ajira_social/common/constants.dart'; // Import for common constants
import 'package:ajira_social/modals/album_modal.dart'; // Import for album modal
import 'package:ajira_social/theme/theme_manager.dart'; // Import for theme manager
import 'package:ajira_social/views/components/body_widget.dart'; // Import for body widget
import 'package:ajira_social/views/screens/home/bloc/album_bloc.dart'; // Import for album BLoC
import 'package:flutter/material.dart'; // Import for Flutter material design components
import 'package:flutter_bloc/flutter_bloc.dart'; // Import for Flutter Bloc

class AlbumDetailScreen extends StatelessWidget {
  const AlbumDetailScreen({
    this.albumModal,
    super.key,
  });

  final AlbumModal? albumModal; // Album modal instance, can be null

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlbumBloc, AlbumState>(
      bloc: context.read<AlbumBloc>()
        ..add(
          GetAlbumPhotoDetailEvent(
            id: albumModal!
                .id, // Trigger the event to get album photo details using the album ID
          ),
        ),
      listener: (context, albumState) {
        // Listener to perform actions based on state changes
        // Currently not implemented, add actions if needed
      },
      builder: (context, albumState) {
        return BodyWidget(
          isLoading: albumState.status ==
              AlbumStatus
                  .loading, // Show loading indicator if status is loading
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                albumModal!.title.toString(),
              ), // Display album title in app bar
              centerTitle: true, // Center the title
            ),
            body: ListView.builder(
              itemCount: albumState.photosModal?.length ??
                  0, // Number of photos in the album
              itemBuilder: (context, index) {
                final album = albumState.photosModal?[
                    index]; // Get the album photo at the current index
                return Padding(
                  padding: horizontalPadding8 +
                      verticalPadding8, // Padding for the list item
                  child: Container(
                    decoration: BoxDecoration(
                      color: context
                          .secondaryContainer, // Set container background color
                      borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                    ),
                    child: Padding(
                      padding: horizontalPadding8 +
                          verticalPadding8, // Padding inside the container
                      child: Column(
                        children: [
                          // Display image or loading indicator if the URL is null or empty
                          if (album!.url == null && album.url!.isEmpty)
                            const CircularProgressIndicator()
                          else
                            Image.network(
                              fit: BoxFit.fitWidth,
                              album.url ?? '', // Display the image from the URL
                            ),
                          // Display thumbnail image and title
                          ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            leading: (album.thumbnailUrl == null &&
                                    album.thumbnailUrl!.isEmpty)
                                ? null
                                : Image.network(
                                    album.thumbnailUrl ??
                                        '', // Display the thumbnail image
                                  ),
                            title: Text(
                              album.title ??
                                  '', // Display the title of the album
                              style: context.titleMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                              ), // Title text style
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
