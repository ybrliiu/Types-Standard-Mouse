requires 'Mouse';
requires 'perl', 'v5.14.0';

on configure => sub {
    requires 'Module::Build::Tiny', '0.035';
};

on test => sub {
    requires 'Module::Load';
    requires 'Test2::V0';
};
