<template>
  <div class="team">
    <h1>Team</h1>
    <h2>Members</h2>
    <ul class="list-group">
      <li class="list-group-item member" v-for="member in members" :key="member.id">
        <img :src="member.identity.image"/>
        {{ member.user.name }}
      </li>
    </ul>
  </div>
</template>

<script>
  import ApiClient from '../../lib/api_client';

  export default {
    data: function() {
      return {
        members: [],
      };
    },
    mounted: function() {
      this.fetchMembers();
    },
    methods: {
      fetchMembers: async function() {
        const { members, error } = await ApiClient.members();
        if (!error) {
          this.members = members;
        } else {
          this.error = error.message;
        }
      },
    }
  };
</script>

<style lang="scss">
  .team {
    .member {
      img {
        width: 30px;
      }
    }
  }
</style>
