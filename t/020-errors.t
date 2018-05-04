#
use v5.24;
use Test2::V0;

plan 3;

eval {
    package BadAttr {
        use Moo;
        use MooX::AttributeFilter;

        has attr => (
            is     => 'ro',
            filter => sub { },
        );
    }
};

like( $@, qr/Incompatibe 'is' option 'ro': can't install filter/,
    "is => 'ro'" );

eval {
    package BadRef {
        use Moo;
        use MooX::AttributeFilter;

        has attr => (
            is     => 'rw',
            filter => {},
        );
    }
};
like(
    $@,
    qr/Attribute 'attr' filter option has invalid value/,
    "filter's incorrect ref"
);

eval {
    package BadMethod {
        use Moo;
        use MooX::AttributeFilter;

        has attr => (
            is     => 'rw',
            filter => 'noFilter',
        );
    }
};
like(
    $@,
    qr/No filter method 'noFilter' defined for BadMethod attribute 'attr'/,
    "no filter method"
);

done_testing;
