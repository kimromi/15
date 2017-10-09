<template>
  <div class="container">
    <h1>Settings</h1>
    <ul class="collection">
      <twitter :identity="twitter"></twitter>
      <github :identity="github"></github>
    </ul>
    <a class="btn-large btn-block" href="/signout">
      Sign out <i class="material-icons fa fa-sign-out fa-2x"></i>
    </a>
  </div>
</template>

<script>
  import axios from 'axios'
  import Twitter from './settings/twitter.vue'
  import Github from './settings/github.vue'

  export default {
    components: {
      twitter: Twitter,
      github: Github
    },
    data: function() {
      return {
        twitter: {},
        github: {}
      }
    },
    mounted: function() {
      this.fetch()
    },
    methods: {
      fetch: function() {
        axios.get('/api/v1/oauth').then(res => {
          for (let identity of res.data) {
            if (identity.provider == 'twitter') this.twitter = identity
            if (identity.provider == 'github')  this.github = identity
          }
        })
      }
    }
  }
</script>
