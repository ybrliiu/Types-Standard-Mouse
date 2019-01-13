use Test2::V0;
use strict;
use warnings;
use Mouse::Util::TypeConstraints;
use Types::Standard::Mouse;

package Hoge {
  use Mouse;
  __PACKAGE__->meta->make_immutable;
}

package Fuga {
  use Mouse;
  __PACKAGE__->meta->make_immutable;
}

subtest array_ref_constraint => sub {
  ok ArrayRef->check([]);

  my $constraint = ArrayRef[ class_type 'Hoge' ];
  isa_ok $constraint, 'Mouse::Meta::TypeConstraint';
  ok $constraint->check([ Hoge->new ]);
  ok !$constraint->check([ Fuga->new ]);
};

subtest hash_ref_constraint => sub {
  ok HashRef->check(+{});

  my $constraint = HashRef[ class_type 'Hoge' ];
  isa_ok $constraint, 'Mouse::Meta::TypeConstraint';
  ok $constraint->check(+{ hoge => Hoge->new });
  ok !$constraint->check(+{ fuga => Fuga->new });
};

subtest maybe_constraint => sub {
  my $constraint = Maybe[ class_type 'Hoge' ];
  isa_ok $constraint, 'Mouse::Meta::TypeConstraint';
  ok $constraint->check(undef);
  ok $constraint->check(Hoge->new);
};

subtest enum => sub {
  my $constraint = enum [qw( A B C )];
  ok $constraint->check($_) for qw( A B C );
  ok !$constraint->check(1000);
};

subtest primitive => sub {
  ok Str->check('str');
  ok Int->check(10);
  ok Num->check(1.2);
};

done_testing;
