<template>
  <div class="settings">
    <h1>Me</h1>
    <twitter :identity="twitter"></twitter>
    <github :identity="github"></github>
  </div>
</template>

<script>
  import axios from 'axios';
  import Twitter from './me/twitter.vue';
  import Github from './me/github.vue';

  export default {
    components: {
      twitter: Twitter,
      github: Github
    },
    data: function() {
      return {
        twitter: {},
        github: {}
      };
    },
    mounted: function() {
      this.fetch();
    },
    methods: {
      fetch: function() {
        axios.get('/api/v1/oauth').then(res => {
          for (let identity of res.data) {
            if (identity.provider == 'twitter') this.twitter = identity;
            if (identity.provider == 'github')  this.github = identity;
          }
        });
      }
    }
  };
</script>
