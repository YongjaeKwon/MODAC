<template>
  <button @click="play('@/assets/music/LOFI.mp3')">Play Button</button>
</template>

<script setup>
const play = (sound) => {
  if (sound) {
    const audio = new Audio(sound)
    audio.play()
  }
}
</script>

<style lang="css" module>

</style>