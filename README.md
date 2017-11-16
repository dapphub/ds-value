<h2>DSValue
  <small class="text-muted">
    <a href="https://github.com/dapphub/ds-value"><span class="fa fa-github"></span></a>
  </small>
</h2>

_Set and get a value_
  
Authorized users can set and unset a value. Anyone can read the value.

### Actions

#### `peek`
return the stored value along with boolean `true` if the value is set and false
if not

#### `read`
return either the stored value or an exception if not set

#### `poke`
set the value (requires auth)

#### `void`
unset the value (requires auth)
