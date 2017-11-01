<template>
  <div class="container">
    <h1>Settings</h1>
    <twitter :identity="twitter"></twitter>
    <github :identity="github"></github>
    <a class="btn btn-default btn-lg btn-block" href="/signout">
      Sign out <i class="fa fa-sign-out"></i>
    </a>
  </div>
</template>

<script>
  import axios from 'axios';
  import Twitter from './settings/twitter.vue';
  import Github from './settings/github.vue';

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
