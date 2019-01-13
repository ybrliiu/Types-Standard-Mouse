use strict;
use Test2::V0;
use Module::Load;

ok lives { load 'Types::Standard::Mouse' };

done_testing;

