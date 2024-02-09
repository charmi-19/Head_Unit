#include "audio.h"
#include "QMediaPlayer"

Audio::Audio() {

}

void Audio::playAudio()
{
    QMediaPlayer *player = new QMediaPlayer;
    // ...
    player->setMedia(QUrl::fromLocalFile("/home/charmi/Music/Sample_Audio.mp3"));
    player->setVolume(50);
    player->play();
}
