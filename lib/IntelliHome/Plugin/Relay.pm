package IntelliHome::Plugin::Relay;

=encoding utf-8

=head1 NAME

IntelliHome::Plugin::Relay - Relay plugin for Google@Home

=head1 SYNOPSIS

  $ ./intellihome-master -i Relay #for install
  $ ./intellihome-master -r Relay #for remove

=head1 DESCRIPTION

IntelliHome::Plugin::Relay is a plugin that enables control of gpio's

=head1 METHODS

=over

=item on

Takes gpio tag as argument and send the request to the remote agent

=item off

Takes gpio tag as argument and send the request to the remote agent

=back

=head1 AUTHOR

mudler E<lt>mudler@dark-lab.netE<gt>

=head1 COPYRIGHT

Copyright 2014- mudler

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO
L<IntelliHome>

=cut

use strict;
use 5.008_005;
our $VERSION = '0.01';
use Moose;
extends 'IntelliHome::Plugin::Base';

sub on{
 my $self=shift;
 my $tag=shift;
 my $GPIO=$self->IntelliHome->Backend->search_gpio($tag);
use Data::Dumper;
print Dumper($GPIO);
}

sub off{
my $self=shift;
 my $tag=shift;
 my $GPIO=$self->IntelliHome->Backend->search_gpio($tag);
use Data::Dumper;
print Dumper($GPIO);
}

sub install {
    my $self = shift;
    ############## MONGODB ##############
    $self->Parser->Backend->installPlugin(
        {   regex         => 'close\s+(.*)',    #We have one global match here
            plugin        => "Relay",
            language      => "en",
            plugin_method => "off"
        }
    ) if $self->Parser->Backend->isa("IntelliHome::Parser::DB::Mongo");
    #####################################
    ############## MONGODB ##############
    $self->Parser->Backend->installPlugin(
        {   regex         => 'chiudi\s+(.*)',    #We have one global match here
            plugin        => "Relay",
            language      => "it",
            plugin_method => "off"
        }
    ) if $self->Parser->Backend->isa("IntelliHome::Parser::DB::Mongo");
    #####################################
    ############## MONGODB ##############
    $self->Parser->Backend->installPlugin(
        {   regex         => 'open\s+(.*)',    #We have one global match here
            plugin        => "Relay",
            language      => "en",
            plugin_method => "on"
        }
    ) if $self->Parser->Backend->isa("IntelliHome::Parser::DB::Mongo");
    #####################################
    ############## MONGODB ##############
    $self->Parser->Backend->installPlugin(
        {   regex         => 'apri\s+(.*)',    #We have one global match here
            plugin        => "Relay",
            language      => "it",
            plugin_method => "on"
        }
    ) if $self->Parser->Backend->isa("IntelliHome::Parser::DB::Mongo");
    #####################################
    return 0;
}

sub remove {
    my $self = shift;

    ############## MONGODB ##############
    $self->IntelliHome->Backend->removePlugin( { plugin => "Relay", } )
        if $self->IntelliHome->Backend->isa("IntelliHome::Parser::DB::Mongo");
    #####################################
    return 0;
}
1;
__END__