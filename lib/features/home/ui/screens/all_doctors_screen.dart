import 'package:advanced_app/core/themes/image.dart'; // Image assets
import 'package:advanced_app/core/themes/style.dart';
import 'package:flutter/material.dart';

// Assuming these paths are correct for your project structure
import '../../../auth/ui/widgets/customtextform.dart'; // Make sure this widget is robust
import '../../data/models/doc_model.dart'; // Ensure DoctorModel is well-defined
import 'doc_details.dart'; // Ensure DoctorDetailsTabScreen exists

/// A screen to display a list of doctors with search and filter capabilities.
class AllDoctorsScreen extends StatefulWidget {
  final List<DoctorModel> doctors;

  const AllDoctorsScreen({
    super.key,
    required this.doctors,
  });

  @override
  State<AllDoctorsScreen> createState() => _AllDoctorsScreenState();
}

class _AllDoctorsScreenState extends State<AllDoctorsScreen> {
  String _searchQuery = ''; // Prefix with _ for private fields
  String _selectedSpecialty = 'All';
  double _selectedRating = 0;

  // Use immutable lists for constant data
  static const List<String> _specialties = [
    'All',
    'General',
    'Neurologic',
    'Pediatric',
    'Cardiology',
    'Dermatology',
    // Add more as needed
  ];
  static const List<double> _ratings = [
    0,
    5,
    4,
    3,
    2,
    1,
  ];

  /// Opens the filter dialog to allow users to select specialty and rating.
  Future<void> _openFilterDialog() async {
    // Use temporary variables for dialog's internal state
    String tempSpecialty = _selectedSpecialty;
    double tempRating = _selectedRating;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        "Sort By",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                      ),
                    ),
                    const Divider(height: 30, thickness: 1, color: Colors.grey),
                    const SizedBox(height: 10),
                    Text(
                      "Speciality",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _specialties.map((spec) {
                        final isSelected = tempSpecialty == spec;
                        return ChoiceChip(
                          label: Text(spec),
                          selected: isSelected,
                          selectedColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          labelStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                          backgroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                            ),
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              setDialogState(() {
                                tempSpecialty = spec;
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      "Rating",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _ratings.map((rate) {
                        final isSelected = tempRating == rate;
                        return ChoiceChip(
                          label: rate == 0
                              ? const Text("All")
                              : Text(
                                  '${rate.toInt()}'), // Use toInt() for cleaner display
                          avatar: rate == 0
                              ? Icon(Icons.star,
                                  color: Theme.of(context).colorScheme.primary,
                                  size: 18)
                              : null,
                          selected: isSelected,
                          selectedColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.2),
                          labelStyle:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Colors.black87,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                          backgroundColor: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                            ),
                          ),
                          onSelected: (selected) {
                            if (selected) {
                              setDialogState(() {
                                tempRating = rate;
                              });
                            }
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context, {
                            'specialty': tempSpecialty,
                            'rating': tempRating,
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor:
                              Theme.of(context).colorScheme.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Done",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // Update main screen's state only if dialog returns a result
    if (result != null) {
      setState(() {
        _selectedSpecialty = result['specialty'];
        _selectedRating = result['rating'];
      });
    }
  }

  /// Filters the list of doctors based on search query, selected specialty, and rating.
  List<DoctorModel> get _filteredDoctors {
    return widget.doctors.where((doc) {
      final matchName = _searchQuery.isEmpty ||
          doc.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchSpecialty = _selectedSpecialty == 'All' ||
          doc.specialization.toLowerCase() == _selectedSpecialty.toLowerCase();
      final matchRating = _selectedRating == 0 || doc.rating >= _selectedRating;
      return matchName && matchSpecialty && matchRating;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // Access theme colors for consistency
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Doctors',
          style: TextStyles.font24Black780Weight
              .copyWith(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface, // Use background color from theme
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    hintText: "Search doctors...",
                    onChanged: (value) => setState(() => _searchQuery = value),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: colorScheme.primary, // Use primary color for button
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.filter_list, color: colorScheme.onPrimary),
                    onPressed: _openFilterDialog,
                    tooltip: 'Filter Doctors',
                  ),
                )
              ],
            ),
          ),
          // Active Filters Display
          if (_selectedSpecialty != 'All' || _selectedRating != 0)
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Text('Active Filters: ',
                      style: textTheme.bodyLarge
                          ?.copyWith(fontWeight: FontWeight.bold)),
                  if (_selectedSpecialty != 'All')
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Chip(
                        label: Text(_selectedSpecialty),
                        onDeleted: () =>
                            setState(() => _selectedSpecialty = 'All'),
                        deleteIcon: const Icon(Icons.cancel_outlined, size: 18),
                        backgroundColor: colorScheme.primary.withOpacity(0.1),
                        labelStyle: textTheme.bodySmall
                            ?.copyWith(color: colorScheme.primary),
                      ),
                    ),
                  SizedBox(
                      width:
                          (_selectedSpecialty != 'All' && _selectedRating != 0)
                              ? 8
                              : 0),
                  if (_selectedRating != 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${_selectedRating.toInt()}'),
                            const Icon(Icons.star,
                                size: 16, color: Colors.amber),
                          ],
                        ),
                        onDeleted: () => setState(() => _selectedRating = 0),
                        deleteIcon: const Icon(Icons.cancel_outlined, size: 18),
                        backgroundColor: colorScheme.primary.withOpacity(0.1),
                        labelStyle: textTheme.bodySmall
                            ?.copyWith(color: colorScheme.primary),
                      ),
                    ),
                ],
              ),
            ),
          Expanded(
            child: _filteredDoctors.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.sentiment_dissatisfied,
                            size: 60, color: Colors.grey[400]),
                        const SizedBox(height: 16),
                        Text(
                          "No doctors found matching your criteria.",
                          style: textTheme.titleMedium
                              ?.copyWith(color: Colors.grey[600]),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredDoctors.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final doctor = _filteredDoctors[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  DoctorDetailsTabScreen(doctor: doctor),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 16),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    AppImages.doctorImage,
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    // Consider adding an errorBuilder for image loading failures
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctor.name,
                                        style: textTheme.titleLarge?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "${doctor.specialization} | ${doctor.practicePlace}",
                                        style: textTheme.bodyMedium
                                            ?.copyWith(color: Colors.grey[700]),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(Icons.star,
                                              color: Colors.amber, size: 18),
                                          const SizedBox(width: 6),
                                          Text(
                                            "${doctor.rating} (${doctor.reviewCount} reviews)",
                                            style: textTheme.bodyMedium
                                                ?.copyWith(
                                                    color: Colors.grey[700]),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Icon(Icons.arrow_forward_ios,
                                      color: Colors.grey[400], size: 18),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
