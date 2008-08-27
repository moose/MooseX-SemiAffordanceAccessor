use strict;
use warnings;

use Test::More tests => 12;


{
    package Standard;

    use Moose;

    has 'thing' => ( is => 'rw' );
    has '_private' => ( is => 'rw' );
}

{
    package SAA;

    use MooseX::SemiAffordanceAccessor;
    use Moose;

    has 'thing' => ( is => 'rw' );
    has '_private' => ( is => 'rw' );
}

{
    package SAA2;

    # Make sure load order doesn't matter
    use Moose;
    use MooseX::SemiAffordanceAccessor;

    has 'thing' => ( is => 'rw' );
    has '_private' => ( is => 'rw' );
}


ok( Standard->can('thing'), 'Standard->thing() exists' );
ok( ! Standard->can('set_thing'), 'Standard->set_thing() does not exist' );
ok( Standard->can('_private'), 'Standard->_private() exists' );
ok( ! Standard->can('_set_private'), 'Standard->_set_private() does not exist' );

ok( SAA->can('thing'), 'SAA->thing() exists' );
ok( SAA->can('set_thing'), 'SAA->set_thing() exists' );
ok( SAA->can('_private'), 'SAA->_private() exists' );
ok( SAA->can('_set_private'), 'SAA->_set_private() exists' );

ok( SAA2->can('thing'), 'SAA2->thing() exists' );
ok( SAA2->can('set_thing'), 'SAA2->set_thing() exists' );
ok( SAA2->can('_private'), 'SAA2->_private() exists' );
ok( SAA2->can('_set_private'), 'SAA2->_set_private() exists' );
