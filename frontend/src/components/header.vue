<template>
  <nav class="navbar navbar-default">
    <div class="container-fluid">
      <div class="navbar-header">
        <a href="/" class="navbar-brand">Fifteen</a>
      </div>

      <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
        <ul class="nav navbar-nav navbar-right">
          <li>
            <router-link to="/">
              <i class="fa fa-pencil-square-o"></i>
            </router-link>
          </li>
          <li>
            <router-link to="/settings">
              <i class="fa fa-cog"></i>
            </router-link>
          </li>
        </ul>
      </div>
    </div>
  </nav>
</template>

<script>
  export default {};
</script>
