<template>
  <div>
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

<style>
  .content {
    padding: 30px 30px 0 230px;
  }
</style>
