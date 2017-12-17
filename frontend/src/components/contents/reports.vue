<template>
  <div class="reports">
    <h1>Reports</h1>

    <transition name="fade" mode="out-in">
      <router-view></router-view>
    </transition>
  </div>
</template>

<script>
  export default {
    data: function() {
      return {
      };
    },
  };
</script>

<style lang="scss">
  .reports {
    .fade-enter-active, .fade-leave-active {
      transition: opacity 0.2s;
    }
    .fade-enter, .fade-leave-to {
      opacity: 0;
    }
  }
</style>
