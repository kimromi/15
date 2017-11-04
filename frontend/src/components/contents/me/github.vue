<template>
  <div>
    <div v-if="authorized()">
      <div @click="disconnect" class="btn btn-default btn-lg btn-block github">
        <i class="fa fa-github"></i> Disconnect
      </div>
    </div>
    <div v-else>
      <a href="/auth/github" class="btn btn-default btn-block btn-lg github">
        <i class="fa fa-github"></i> Connect
      </a>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    props: [
      'identity',
    ],
    methods: {
      authorized: function() {
        return this.identity.provider == 'github';
      },
      disconnect: function() {
        axios.delete('/api/v1/oauth/github').then(() => {
          this.identity = {};
        });
      }
    }
  };
</script>

<style lang="scss" scoped>
  .github {
    color: #FFF;
    background-color: #333 !important;
  }
</style>
