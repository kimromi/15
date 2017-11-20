<template>
  <div class="app">
    <sidebar></sidebar>
    <div class="content">
      <transition name="fade" mode="out-in">
        <router-view></router-view>
      </transition>
    </div>
  </div>
</template>

<script>
  import { mapActions } from 'vuex';
  import Sidebar from './sidebar.vue';
  import ApiClient from '../lib/api_client';

  export default {
    components: {
      sidebar: Sidebar
    },
    created: async function() {
      let { tasks } = await ApiClient.tasks();
      this.setTasks(tasks);
    },
    methods: {
      ...mapActions([
        'setTasks'
      ]),
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

    .fade-enter-active, .fade-leave-active {
      transition: opacity 0.2s;
    }
    .fade-enter, .fade-leave-to {
      opacity: 0;
    }
  }
</style>
