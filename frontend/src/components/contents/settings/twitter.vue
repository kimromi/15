<template>
  <div>
    <div v-if="authorized()">
      <div @click="disconnect" class="btn btn-default btn-lg btn-block twitter">
        <i class="fa fa-twitter"></i> Disconnect
      </div>
    </div>
    <div v-else>
      <a href="/auth/twitter" class="btn btn-default btn-lg btn-block twitter">
        <i class="fa fa-twitter"></i> Connect
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
        return this.identity.provider == 'twitter';
      },
      disconnect: function() {
        axios.delete('/api/v1/oauth/twitter').then(() => {
          this.identity = {};
        });
      }
    }
  };
</script>

<style scoped>
  .twitter {
    color: #FFF;
    background-color: #00aced !important;
  }
</style>
