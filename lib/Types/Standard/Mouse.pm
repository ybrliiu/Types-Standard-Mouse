package Types::Standard::Mouse;

use v5.14;
use strict;
use warnings;
use utf8;
use Carp ();
use Mouse::Exporter;
use Mouse::Util::TypeConstraints;

our $VERSION = '0.01';

my @constraints =
  Mouse::Util::TypeConstraints::list_all_builtin_type_constraints();

for my $constraint (@constraints) {
  no strict 'refs';
  unless ( defined *{$constraint}{CODE} ) {
    *{$constraint} = sub {
      use strict 'refs';
      Mouse::Util::TypeConstraints::find_or_parse_type_constraint($constraint);
    };
  }
}

Mouse::Exporter->setup_import_methods( as_is => \@constraints );

sub ArrayRef(;$) {
  my $arrayref = shift;
  my $constraint = ref $arrayref eq 'ARRAY' ? $arrayref->[0] : undef;
  my $array_constraint =
    Mouse::Util::TypeConstraints::find_or_parse_type_constraint('ArrayRef');
  defined $constraint
    ? $array_constraint->parameterize($constraint)
    : $array_constraint;
}

sub HashRef(;$) {
  my $arrayref = shift;
  my $constraint = ref $arrayref eq 'ARRAY' ? $arrayref->[0] : undef;
  my $hash_constraint =
    Mouse::Util::TypeConstraints::find_or_parse_type_constraint('HashRef');
  defined $constraint
    ? $hash_constraint->parameterize($constraint)
    : $hash_constraint;
}

sub Maybe($) {
  my $arrayref = shift;
  my $constraint = ref $arrayref eq 'ARRAY'
    ? $arrayref->[0]
    : Carp::croak('You should be pass constraint.');
  maybe_type($constraint);
}

1;

__END__

=encoding utf-8

=head1 NAME

Types::Standard::Mouse - bundled set of built-in types for Mouse

=head1 SYNOPSIS

    use Types::Standard::Mouse;

=head1 DESCRIPTION

Mouse::Util::TypeConstraints bundles a few types which seem to be useful. (like Types::Standard) 

=head1 LICENSE

Copyright (C) mp0liiu.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

mp0liiu E<lt>raian@reeshome.orgE<gt>

=cut

