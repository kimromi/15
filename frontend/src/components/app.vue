<template>
  <div class="app">
    <sidebar></sidebar>
    <div class="content">
      <router-view></router-view>
    </div>
  </div>
</template>

<script>
  import Sidebar from './sidebar.vue';

  export default {
    components: {
      sidebar: Sidebar
    }
  };
</script>

<style lang="scss">
  .app {
    height: 100%;

    .content {
      height: 100%;
      padding: 0 30px 0 230px;
    }
  }
</style>
