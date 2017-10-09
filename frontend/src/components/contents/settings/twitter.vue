<template>
  <li class="collection-item avatar" v-cloak>
    <div v-if="authorized()">
      <i class="material-icons circle twitter fa fa-twitter fa-2x"></i>
      <span class="title">Twitter</span>
      <p>authorized by <a :href="twitterUrl()" target="_blank">{{ identity.nickname }}</a></p>
      <div @click="disconnect" class="secondary-content btn btn-block waves-effect waves-light">disconnect</div>
    </div>
    <div v-else>
      <i class="material-icons circle fa fa-twitter fa-2x"></i>
      <span class="title">Twitter</span>
      <p>not authorized</p>
      <a href="/auth/twitter" class="secondary-content btn btn-block twitter">
        <i class="material-icons left fa fa-twitter"></i> connect
      </a>
    </div>
  </li>
</template>

<script>
  import axios from 'axios'

  export default {
    props: [
      'identity',
    ],
    methods: {
      authorized: function() {
        return this.identity.provider == 'twitter';
      },
      twitterUrl: function() {
        return this.authorized() ? `https://twitter.com/${this.identity.nickname}` : '';
      },
      disconnect: function() {
        axios.delete('/api/v1/oauth/twitter').then(res => {
          this.identity = {}
        })
      }
    }
  }
</script>

<style scoped>
  .twitter {
    background-color: #00aced !important;
  }
</style>
