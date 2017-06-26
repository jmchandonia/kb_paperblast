package kb_paperblast::kb_paperblastImpl;
use strict;
use Bio::KBase::Exceptions;
# Use Semantic Versioning (2.0.0-rc.1)
# http://semver.org 
our $VERSION = '0.0.1';
our $GIT_URL = 'git@github.com:kbaseapps/kb_paperblast.git';
our $GIT_COMMIT_HASH = '02fe5ea0c2c99d38111b24969d37d9882b228732';

=head1 NAME

kb_paperblast

=head1 DESCRIPTION

This KBase module is a wrapper for PaperBLAST

=cut

#BEGIN_HEADER
#END_HEADER

sub new
{
    my($class, @args) = @_;
    my $self = {
    };
    bless $self, $class;
    #BEGIN_CONSTRUCTOR
    #END_CONSTRUCTOR

    if ($self->can('_init_instance'))
    {
	$self->_init_instance();
    }
    return $self;
}

=head1 METHODS



=head2 paperblast_seq

  $output = $obj->paperblast_seq($params)

=over 4

=item Parameter and return types

=begin html

<pre>
$params is a kb_paperblast.PaperBLASTSeqParams
$output is a kb_paperblast.PaperBLASTOutput
PaperBLASTSeqParams is a reference to a hash where the following keys are defined:
	ws has a value which is a string
	sequence has a value which is a string
PaperBLASTOutput is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string

</pre>

=end html

=begin text

$params is a kb_paperblast.PaperBLASTSeqParams
$output is a kb_paperblast.PaperBLASTOutput
PaperBLASTSeqParams is a reference to a hash where the following keys are defined:
	ws has a value which is a string
	sequence has a value which is a string
PaperBLASTOutput is a reference to a hash where the following keys are defined:
	report_name has a value which is a string
	report_ref has a value which is a string


=end text



=item Description



=back

=cut

sub paperblast_seq
{
    my $self = shift;
    my($params) = @_;

    my @_bad_arguments;
    (ref($params) eq 'HASH') or push(@_bad_arguments, "Invalid type for argument \"params\" (value was \"$params\")");
    if (@_bad_arguments) {
	my $msg = "Invalid arguments passed to paperblast_seq:\n" . join("", map { "\t$_\n" } @_bad_arguments);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'paperblast_seq');
    }

    my $ctx = $kb_paperblast::kb_paperblastServer::CallContext;
    my($output);
    #BEGIN paperblast_seq

    # only input is AA sequence:
    if (!exists $params->{'sequence'}) {
        die "Parameter 'sequence' is not set in input arguments";
    }
    my $sequence = $params->{'sequence'};

    # sanitize sequence

    # load output into variable
    my $htmlOutput = `dependencies/PaperBLAST/cgi/litSearch.cgi "query=>sequence%0D%0$sequence&Search=Search"`

    #END paperblast_seq
    my @_bad_returns;
    (ref($output) eq 'HASH') or push(@_bad_returns, "Invalid type for return variable \"output\" (value was \"$output\")");
    if (@_bad_returns) {
	my $msg = "Invalid returns passed to paperblast_seq:\n" . join("", map { "\t$_\n" } @_bad_returns);
	Bio::KBase::Exceptions::ArgumentValidationError->throw(error => $msg,
							       method_name => 'paperblast_seq');
    }
    return($output);
}




=head2 status 

  $return = $obj->status()

=over 4

=item Parameter and return types

=begin html

<pre>
$return is a string
</pre>

=end html

=begin text

$return is a string

=end text

=item Description

Return the module status. This is a structure including Semantic Versioning number, state and git info.

=back

=cut

sub status {
    my($return);
    #BEGIN_STATUS
    $return = {"state" => "OK", "message" => "", "version" => $VERSION,
               "git_url" => $GIT_URL, "git_commit_hash" => $GIT_COMMIT_HASH};
    #END_STATUS
    return($return);
}

=head1 TYPES



=head2 PaperBLASTSeqParams

=over 4



=item Description

Run PaperBLAST against a single sequence


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
ws has a value which is a string
sequence has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
ws has a value which is a string
sequence has a value which is a string


=end text

=back



=head2 PaperBLASTOutput

=over 4



=item Description

PaperBLAST output is just an HTML report


=item Definition

=begin html

<pre>
a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string

</pre>

=end html

=begin text

a reference to a hash where the following keys are defined:
report_name has a value which is a string
report_ref has a value which is a string


=end text

=back



=cut

1;