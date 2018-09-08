packageOverrides = super: rec {

  haskellEnvFun = { withHoogle ? false, compiler ? null, name }:
  let hp = if compiler != null
             then super.haskell.packages.${compiler}
             else haskellPackages;

      ghcWith = if withHoogle
                  then hp.ghcWithHoogle
                  else hp.ghcWithPackages;

  in super.buildEnv {
    name = name;
    paths = [(ghcWith myHaskellPackages)];
  };

  haskellEnvHoogle = haskellEnvFun {
    name = "haskellEnvHoogle";
    withHoogle = true;
  };

  haskellEnv = haskellEnvFun {
    name = "haskellEnv";
    withHoogle = false;
  };
  myHaskellPackages = hp: with hp; [
    Boolean
    HTTP
    HUnit
    MissingH
    QuickCheck
    SafeSemaphore
    Spock
    aeson
    async
    attoparsec
    bifunctors
    blaze-builder
    blaze-builder-conduit
    blaze-builder-enumerator
    blaze-html
    blaze-markup
    blaze-textual
    cased
    cassava
    cereal
    comonad
    comonad-transformers
    directory_1_2_4_0
    dlist
    dlist-instances
    doctest
    exceptions
    fingertree
    foldl
    free
    hamlet
    hashable
    hspec
    hspec-expectations
    html
    http-client
    http-date
    http-types
    io-memoize
    keys
    language-c
    language-javascript
    language-bash
    lens
    lens-action
    lens-aeson
    lens-datetime
    lens-family
    lens-family-core
    lifted-async
    lifted-base
    linear
    list-extras
    list-t
    logict
    mime-mail
    mime-types
    mmorph
    monad-control
    monad-coroutine
    monad-loops
    monad-par
    monad-par-extras
    monad-stm
    monadloc
    mongoDB
    monoid-extras
    network
    newtype
    numbers
    optparse-applicative
    parsec
    parsers
    pcg-random
    persistent
    persistent-mongoDB
    persistent-template
    pipes
    pipes-async
    pipes-attoparsec
    pipes-binary
    pipes-bytestring
    pipes-concurrency
    pipes-csv
    pipes-extras
    pipes-group
    pipes-http
    pipes-mongodb
    pipes-network
    pipes-parse
    pipes-safe
    pipes-shell
    pipes-text
    posix-paths
    postgresql-simple
    pretty-show
    profunctors
    random
    reducers
    reflection
    regex-applicative
    regex-base
    regex-compat
    regex-posix
    regular
    relational-record
    resourcet
    retry
    rex
    safe
    sbv
    scotty
    semigroupoids
    semigroups
    shake
    shakespeare
    shelly
    simple-reflect
    speculation
    split
    spoon
    stm
    stm-chans
    stm-stats
    streaming
    streaming-bytestring
    streaming-wai
    strict
    stringsearch
    strptime
    syb
    system-fileio
    system-filepath
    tagged
    taggy
    taggy-lens
    tar
    tardis
    tasty
    tasty-hspec
    tasty-hunit
    tasty-quickcheck
    tasty-smallcheck
    temporary
    test-framework
    test-framework-hunit
    text
    text-format
    time
    tinytemplate
    transformers
    transformers-base
    turtle
    uniplate
    unix-compat
    unordered-containers
    uuid
    vector
    void
    wai
    wai-conduit
    warp
    wreq
    xhtml
    yaml
    zippers
    zlib




  ];

};
