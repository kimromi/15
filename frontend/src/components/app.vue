<template>
  <div>
    <app_header></app_header>
    <router-view></router-view>
  </div>
</template>

<script>
  import Header from './header.vue';

  export default {
    components: {
      app_header: Header
    }
  };
</script>

<style>
  [v-cloak] {
    display: none;
  }
</style>
