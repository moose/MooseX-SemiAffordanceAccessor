package MooseX::SemiAffordanceAccessor::Role::Attribute;

use strict;
use warnings;

use Moose::Role;


before '_process_options' => sub
{
    my $class   = shift;
    my $name    = shift;
    my $options = shift;

    if ( exists $options->{is} &&
         ! ( exists $options->{reader} || exists $options->{writer} ) )
    {
        if ( $options->{is} eq 'ro' )
        {
            $options->{reader} = $name;
        }
        elsif ( $options->{is} eq 'rw' )
        {
            $options->{reader} = $name;

            my $prefix = 'set';
            if ( $name =~ s/^_// )
            {
                $prefix = '_set';
            }

            $options->{writer} = $prefix . q{_} . $name;
        }

        delete $options->{is};
    }
};

no Moose::Role;

1;
