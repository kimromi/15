<template>
  <li class="collection-item avatar" v-cloak>
    <div v-if="authorized()">
      <i class="material-icons circle github fa fa-github fa-2x"></i>
      <span class="title">GitHub</span>
      <p>authorized by <a :href="githubUrl()" target="_blank">{{ identity.nickname }}</a></p>
      <div @click="disconnect" class="secondary-content btn btn-block waves-effect waves-light">disconnect</div>
    </div>
    <div v-else>
      <i class="material-icons circle fa fa-github fa-2x"></i>
      <span class="title">GitHub</span>
      <p>not authorized</p>
      <a href="/auth/github" class="secondary-content btn btn-block github">
        <i class="material-icons left fa fa-github"></i> connect
      </a>
    </div>
  </li>
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
      githubUrl: function() {
        return this.authorized() ? `https://github.com/${this.identity.nickname}` : '';
      },
      disconnect: function() {
        axios.delete('/api/v1/oauth/github').then(() => {
          this.identity = {};
        });
      }
    }
  };
</script>

<style scoped>
  .github {
    background-color: #333 !important;
  }
</style>
