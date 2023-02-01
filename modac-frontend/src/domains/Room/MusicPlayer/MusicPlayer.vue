<template>
  <div class="music_body">
    <div class="music">
      <h2 class="title">Music Name</h2>
      <div class="player">
        <audio id="music_player">
          <source id="music_src" src="./LOFI.mp3"/>
        </audio>
        <div class="buttons">
          <span class="prev" @click="prevSong">
              <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
                <path stroke-linecap="round" stroke-linejoin="round" d="M21 16.811c0 .864-.933 1.405-1.683.977l-7.108-4.062a1.125 1.125 0 010-1.953l7.108-4.062A1.125 1.125 0 0121 8.688v8.123zM11.25 16.811c0 .864-.933 1.405-1.683.977l-7.108-4.062a1.125 1.125 0 010-1.953L9.567 7.71a1.125 1.125 0 011.683.977v8.123z" />
              </svg>
          </span>
          <span class="playPause" @click="playOrPause">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-12 h-12 ml-1">
              <path stroke-linecap="round" stroke-linejoin="round" d="M5.25 5.653c0-.856.917-1.398 1.667-.986l11.54 6.348a1.125 1.125 0 010 1.971l-11.54 6.347a1.125 1.125 0 01-1.667-.985V5.653z" />
            </svg>
          </span>
          <span class="next" @click="nextSong">
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-6 h-6">
              <path stroke-linecap="round" stroke-linejoin="round" d="M3 8.688c0-.864.933-1.405 1.683-.977l7.108 4.062a1.125 1.125 0 010 1.953l-7.108 4.062A1.125 1.125 0 013 16.81V8.688zM12.75 8.688c0-.864.933-1.405 1.683-.977l7.108 4.062a1.125 1.125 0 010 1.953l-7.108 4.062a1.125 1.125 0 01-1.683-.977V8.688z" />
            </svg>
          </span>
        </div>
      </div>
    </div>
  </div>
</template>


<script setup>
  import { ref, onMounted } from 'vue'
  let title = undefined 
  let prev = undefined 
  let playPause = undefined 
  let next = undefined 
  let audio = undefined
  let music_src = undefined


      // 음악 리스트 생성
      const songList = [
      {
        path: './LOFI.mp3',
        songName: 'LOFI'
      },
    ]
    let song_Playing = ref(false);

    function playSong(){
      song_Playing.value = true;
      audio.play();
      playPause.classList.add('active');
      // 아이콘 변경
      playPause.innerHTML = 
      `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-12 h-12 ml-1">
        <path stroke-linecap="round" stroke-linejoin="round" d="M5.25 5.653c0-.856.917-1.398 1.667-.986l11.54 6.348a1.125 1.125 0 010 1.971l-11.54 6.347a1.125 1.125 0 01-1.667-.985V5.653z" />
      </svg>`
    }

    const pauseSong = () => {
      song_Playing.value = false;
      audio.pause();
      playPause.classList.remove('active');
      playPause.innerHTML = 
      `<svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-12 h-12">
        <path stroke-linecap="round" stroke-linejoin="round" d="M15.75 5.25v13.5m-7.5-13.5v13.5" />
      </svg>`
    }

    // 클릭 시 음악 재생 혹은 멈춤
    const playOrPause = () => {
      song_Playing.value ? pauseSong(): playSong()
    }

    // 음악 재생
    const loadSong = (songList) => {
      title.textContent = songList.songName;
      music_src.src = songList.path;
      audio.play()
    }

    // 현재 음악
    let i = 0;

    // 처음 재생 시 리스트의 첫 번째 음악 재생
    // loadSong(songList[i])

    // 이전 곡
    const prevSong = () => {
      i--;
      if (i < 0){
        i = songList.length - 1;
      }
      loadSong(songList[i]);
      playSong();
    }

    // 다음 곡
    const nextSong = () => {
      i++;
      if (i > songList.length - 1){
        i = 0;
      }
      loadSong(songList[i]);
      playSong();
    }

  onMounted(() => {
    title = document.querySelector(".title")
    prev = document.querySelector(".prev");
    playPause = document.querySelector(".playPause");
    next = document.querySelector(".next");
    audio = document.querySelector("#music_player");
    music_src = document.querySelector('#music_src')

    loadSong(songList[i])
})

</script>

<style lang="css" >
@import './MusicPlayer.module.css'

</style>