<template>
  <div>
    <nav>
      <div class="nav-wrapper">
        <a href="/app" class="brand-logo">fifteen</a>
        <ul class="right hide-on-med-and-down">
          <li>
            <router-link to="/">
              <i class="material-icons fa fa-pencil-square-o fa-2x"></i>
            </router-link>
          </li>
          <li>
            <router-link to="/settings">
              <i class="material-icons fa fa-cog fa-2x"></i>
            </router-link>
          </li>
        </ul>
      </div>
    </nav>
  </div>
</template>

<script>
  export default {};
</script>
