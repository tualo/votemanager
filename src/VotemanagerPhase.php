<?php

namespace Tualo\Office\VoteManager;

use Tualo\Office\Basic\TualoApplication as App;
use Tualo\Office\Basic\Session as Session;

enum VotemanagerPhase: string
{
    case Setup = 'setup_phase';
    case Test = 'test_phase';
    case Production = 'production_phase';
    case Council = 'council_phase';
    case Reset = 'reset_phase';
    case Unknown = 'unknown_phase';
}
