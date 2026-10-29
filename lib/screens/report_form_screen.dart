// report_form_screen.dart - Report an Issue form screen. Simulates async reporting
// with in-memory storage and no network calls.

import 'package:flutter/material.dart';
import 'package:tutormatch_ai/widgets/app_button.dart';
import 'package:tutormatch_ai/widgets/app_text_field.dart';

/// UI states for the report form, driven by simulated async work.
enum ReportUiState { idle, loading, success, empty, error }

class _Report {
  final String title;
  final String category;

  const _Report(this.title, this.category);
}

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({super.key});

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _category;
  final List<_Report> _reports = <_Report>[];
  ReportUiState _uiState = ReportUiState.idle;
  bool _simulateFailure = false;
  bool _isLoading = false;
  bool _showingMyReports = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _category = null;
  }

  Future<void> _submit() async {
    if (_isLoading) {
      return;
    }
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
      _uiState = ReportUiState.loading;
    });

    try {
      await Future.delayed(const Duration(seconds: 3));
      if (_simulateFailure) {
        throw Exception('Simulated failure for demo only.');
      }
      _reports.add(_Report(_titleController.text.trim(), _category!));
      if (mounted) {
        setState(() {
          _isLoading = false;
          _uiState = ReportUiState.success;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _uiState = ReportUiState.error;
        });
      }
      _simulateFailure = false;
    }
  }

  void _onViewReports() {
    if (_reports.isEmpty) {
      setState(() {
        _uiState = ReportUiState.empty;
      });
      return;
    }
    setState(() {
      _showingMyReports = true;
    });
  }

  void _onCreateReport() {
    setState(() {
      _uiState = ReportUiState.idle;
      _showingMyReports = false;
    });
  }

  void _onSubmitAnother() {
    _clearForm();
    setState(() {
      _uiState = ReportUiState.idle;
    });
  }

  void _onEditReport() {
    setState(() {
      _uiState = ReportUiState.idle;
    });
  }

  void _onBackToForm() {
    setState(() {
      _showingMyReports = false;
    });
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Report an Issue',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 4),
        Text(
          'Help us improve TutorMatch A.I.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildForm() {
    final bool isLoading = _uiState == ReportUiState.loading;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          AppTextField(
            label: 'Report title',
            hintText: 'Enter a report title',
            controller: _titleController,
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a report title.';
              }
              if (value.length < 5) {
                return 'Title must be at least 5 characters.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            initialValue: _category,
            hint: const Text('Choose a category'),
            items: const [
              DropdownMenuItem(value: 'Tutor behavior', child: Text('Tutor behavior')),
              DropdownMenuItem(value: 'Wrong match result', child: Text('Wrong match result')),
              DropdownMenuItem(value: 'Booking problem', child: Text('Booking problem')),
              DropdownMenuItem(value: 'App bug', child: Text('App bug')),
            ],
            onChanged: (value) {
              if (value != null) {
                _category = value;
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Choose a category.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Description',
            hintText: 'Enter a description',
            controller: _descriptionController,
            maxLines: 4,
            maxLength: 200,
            enabled: !isLoading,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter a description.';
              }
              if (value.length < 10) {
                return 'Description must be at least 10 characters.';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            value: _simulateFailure,
            onChanged: (value) {
              setState(() {
                _simulateFailure = value;
              });
            },
            title: const Text('Simulate failure (demo only)'),
          ),
          const SizedBox(height: 16),
          AppButton(
            label: 'Submit Report',
            isLoading: isLoading,
            onPressed: isLoading ? null : _submit,
          ),
          const SizedBox(height: 12),
          AppButton(
            label: 'View My Reports',
            isSecondary: true,
            onPressed: isLoading ? null : _onViewReports,
          ),
        ],
      ),
    );
  }


  Widget _buildLoadingPanel() {
    return _StatePanel(
      icon: CircularProgressIndicator(strokeWidth: 2),
      title: 'Submitting your report...',
      message: 'We are submitting your report. Please wait a moment.',
      circleColor: Colors.blue,
    );
  }

  Widget _buildSuccessPanel() {
    return _StatePanel(
      icon: const Icon(Icons.check_circle_rounded, color: Colors.green),
      title: 'Report submitted',
      message: 'Your report has been submitted successfully. This response is simulated - the report is stored in memory only (no server call was made).',
      actions: [
        AppButton(label: 'Submit another', onPressed: _onSubmitAnother),
        AppButton(label: 'View My Reports', isSecondary: true, onPressed: _onViewReports),
      ],
    );
  }

  Widget _buildEmptyPanel() {
    return _StatePanel(
      icon: const Icon(Icons.inbox_rounded, color: Colors.blue),
      title: 'No reports yet',
      message: 'You haven\'t submitted any reports yet. Tap "Create a report" below to add your first report.',
      actions: [
        AppButton(label: 'Create a report', onPressed: _onCreateReport),
      ],
    );
  }

  Widget _buildErrorPanel() {
    return _StatePanel(
      icon: const Icon(Icons.error_outline_rounded, color: Colors.red),
      title: 'Could not submit your report',
      message: 'Something went wrong. The "Simulate failure (demo only)" switch was on. Your typed answers were kept so you don\'t need to retype them.',
      actions: [
        AppButton(label: 'Retry', onPressed: _submit),
        AppButton(label: 'Edit report', isSecondary: true, onPressed: _onEditReport),
      ],
    );
  }


  Widget _buildStatePanel() {
    Widget panel;
    switch (_uiState) {
      case ReportUiState.idle:
        panel = _buildForm();
        break;
      case ReportUiState.loading:
        panel = _buildLoadingPanel();
        break;
      case ReportUiState.success:
        panel = _buildSuccessPanel();
        break;
      case ReportUiState.empty:
        panel = _buildEmptyPanel();
        break;
      case ReportUiState.error:
        panel = _buildErrorPanel();
        break;
    }
    if (_uiState == ReportUiState.loading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          panel,
          _buildForm(),
        ],
      );
    }
    return panel;
  }

  Widget _buildMyReportsPanel() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.list_alt_rounded, size: 22, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'My Reports',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ..._reports.map((_Report report) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_rounded, size: 18, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              report.title,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            Text(
                              report.category,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            AppButton(
              label: 'Back to form',
              onPressed: _onBackToForm,
            ),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Color(0xFF1B7F4B)),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.surface,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 560),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  if (_showingMyReports) _buildMyReportsPanel(),
                  if (!_showingMyReports) _buildStatePanel(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatePanel extends StatelessWidget {
  final String title;
  final String message;
  final List<Widget> actions;
  final Widget? icon;
  final Color? circleColor;

  const _StatePanel({
    required this.title,
    required this.message,
    this.actions = const <Widget>[],
    this.icon,
    this.circleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (icon != null)
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: circleColor ?? Theme.of(context).colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Center(child: icon),
            ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          if (actions.isNotEmpty) _buildActions(context),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final action in actions)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: action,
          ),
      ],
    );
  }
}


