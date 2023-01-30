<template>
  <div :class="$style.clock_body"></div>
  <div :id="$style.clock">
      <p :class="$style.time">{{ time }} 동안</p>
      <p :class="$style.text">공부중</p>
  </div>
</template>

<script setup>
import { ref } from "vue";
const time = ref('00:00:00')

</script>

<style lang="css" module>
@import './MainTimer.module.css'
</style>