# EEG-Analysis

This project focuses on the analysis of Electroencephalogram (EEG) brain signals to understand cognitive behavior, mental workload, fatigue patterns, and neural responses across different subject groups. The EEG dataset contains high-frequency time-series data along with behavioral and demographic attributes such as Diagnosis, Sex, Session, Events, EEG Power Bands, SNR, Fatigue Levels, Engagement Index, and more.

Python and R were used together to build a complete data analysis pipeline, covering data cleaning, feature extraction, visualization, statistical analysis, and interpretation.

# **Key Objectives**

1. Clean and preprocess EEG data (handle missing values, outliers, encoding scaling)

2. Extract meaningful EEG features (Alpha, Beta, Theta, Gamma, SNR)

3. Analyze cognitive states, neural activity patterns, and fatigue

4. Compare EEG behavior across Diagnosis, Sex, and Session

5. Visualize distributions and relationships using Python, R, and Plotly (interactive)

6. Provide clinically meaningful insights for neuroscience applications

# **Approach & Methodology**

**1. Data Preprocessing**

1.1. Handling missing values using median/mode imputation

1.2. Outlier treatment with IQR method

1.3. Encoding categorical attributes (Diagnosis, Sex, Event)

1.4. Scaling numerical EEG features

1.5. R used for statistical validation and visualization

**2. Feature Engineering**

2.1. Extracted EEG-related features such as:

2.2. Alpha, Beta, Theta, Gamma Power

2.3. SNR (Signal-to-Noise Ratio)

2.4. Fatigue Level

2.5. Engagement Index

2.6. Channel Difference & Artifact Score

**3. Exploratory Data Analysis**

Performed 12+ visual analyses, including:

3.1. Distribution plots for EEG power bands

3.2. Engagement Index trend analysis

3.3. Diagnosis-wise boxplots

3.4. EEG Channel difference assessment

3.5. Correlation heatmaps

3.6. Interactive scatter plots (Plotly)

3.7. Pairplots to understand inter-feature relationships

3.8. Fatigue distribution

3.9. Event-wise EEG changes

**4. Tools & Technologies**

4.1. Python: pandas, seaborn, matplotlib, plotly, numpy

4.2. R: ggplot2, ggpairs, plotly, dplyr


# **Project Insights**

**1. Alpha, Beta, Theta & Gamma Power Distributions**

•	Alpha and Theta power show higher variance, indicating subjects may be in mixed states of relaxation, attention, and drowsiness.

•	Beta and Gamma power appear more concentrated for most subjects, suggesting consistent cognitive activity across trials.

**2. Diagnosis-wise EEG Differences**

•	Subjects with Cognitive Disorder category show:

o	Lower Alpha power (difficulty relaxing)
o	Higher Theta in some cases (inattention / fatigue)
o	Slightly lower SNR, meaning noisier EEG signals

•	Healthy subjects show stronger Gamma activity, indicating better cognitive integration.

**3. EEG Channel Difference (EEG_Ch1 vs EEG_Ch2)** 

•	Channel differences remain stable for most subjects → indicates good electrode placement.

•	A few subjects show unusually high difference → likely artifact contamination.

**4. Fatigue Level Pattern**

•	The distribution indicates:

o	Most subjects fall in moderate fatigue range.
o	A tail of high fatigue values points to extended task duration or cognitive overload.

**5. Engagement Index Over Time**

•	Initial high engagement gradually dips → indicates:

o	Reduced attention as trial progresses.
o	Possible task monotony or mental fatigue.

•	Sudden spikes in some cases → possibly stimulus events or artifact moments.

**6. Cognitive Load vs Sex**

•	Cognitive load seems slightly higher in females (if seen in your plot),
but the difference is not extremely large.

•	High variability indicates cognitive load is influenced more by task type than by biological sex.

**7. SNR vs Gamma Power**

•	Higher SNR is correlated with higher GammaPower → meaning:

o	Cleaner EEG signals produce stronger high-frequency information.

•	Low SNR cluster likely represents movement artifacts or electrode noise.

**8. Event-Wise Differences**

•	Trials where “Start”, “Task”, or “Stimulus” occurred show:

o	Higher Beta/Gamma (active cognitive phase)
o	Lower Alpha (reduced relaxation)

**9. Artifact Score**

•	Subjects with high artifact scores correlate with:

o	Lower SNR
o	Higher Channel differences

•	Suggests eye blinks, muscle noise, or poor electrode contact.

# **Recommendations**

**1. Alpha, Beta, Theta & Gamma Power Distributions**

•	Apply state-specific segmentation (rest vs task) to better isolate patterns.

•	Use band-specific normalization to reduce subject-to-subject variability.

•	Perform ICA or advanced filtering to ensure the high variance isn’t caused by artifacts.

**2. Diagnosis-wise EEG Differences**

•	Integrate Alpha-Theta ratio as an early diagnostic feature.

•	Use SNR thresholding before feature extraction to ensure cleaner signals.

•	Consider building a classification model (e.g., Random Forest, SVM) to differentiate diagnosis groups using these biomarkers.

**3. EEG Channel Difference (EEG_Ch1 vs EEG_Ch2)**

•	Apply automatic channel quality checks before analysis.

•	Flag subjects with high ChannelDiff values for manual inspection.

•	Consider using re-referencing techniques (CAR, Laplacian) to stabilize channel differences.

**4. Fatigue Level Pattern**

•	Use task break indicators for subjects with consistently high fatigue levels.

•	Apply sliding-window analysis to estimate real-time fatigue trends.

•	Build a fatigue prediction model using Theta/Alpha ratio and Engagement Index.

**5. Engagement Index Over Time**

•	Implement micro-break suggestions during long tasks.

•	Use rising and falling engagement patterns as features in cognitive load prediction.

•	Evaluate engagement alongside event markers to identify exact causes of dips.

**6. Cognitive Load vs Sex**

•	Analyze cognitive load per task type, not just sex, to avoid bias.

•	Include more demographic factors (age, diagnosis, education level) in modeling.

•	Use cognitive load as a personalized parameter rather than a group-level one.

**7. SNR vs Gamma Power**

•	Use SNR-based weighting when calculating GammaPower features.

•	Apply artifact removal (ICA, notch filters) to improve SNR before analysis.

•	Skip low-SNR segments in machine learning models to avoid performance drop.

**8. Event-Wise Differences**

•	Segment and analyze EEG event-wise instead of full sequence processing.

•	Use Beta/Gamma features for task engagement or workload detection.

•	Build event-specific feature summaries for clinicians.

**9. Artifact Score**

•	Set artifact score cut-off thresholds to remove noisy segments.

•	Apply automatic artifact rejection tools (e.g., Wavelet Denoising, ASR).

•	Re-train your models with and without artifact-heavy recordings to test performance.


# **Conclusion**

This project demonstrates how EEG signals can be used to evaluate cognitive function, fatigue, diagnosis differences, and signal quality. By integrating Python, R the workflow becomes robust, reproducible, and clinically valuable.

The insights discovered can help neuroscientists, psychologists, and clinicians better understand brain activity patterns, detect anomalies, assess treatment progress, and design cognitive experiments.

