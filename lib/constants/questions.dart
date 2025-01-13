// ignore_for_file: constant_identifier_names

const questions = {
  "Restricted Repetitive Behavior" : [
    "If left alone, the majority of the individuals time will be spent in repetitive or stereotyped behaviors.",
    "Is preoccupied with specific stimuli that are abnormal in intensity.",
    "Stares at hands, objects, or items in the enviornment for at least 5 seconds.",
    "Flicks fingers rapidly in front of eyes for periods of 5 seconds or more.",
    "Makes rapid lunging, darting movements when moving from place to place.",
    "Flaps hands or fingers in front of face or at sides."
    "Make high-pitched sounds (e.g., eee-eee-eee-eee) or other vocalizations for self-stimulatoin.",
    "Uses toys or objects inappropriately (e.g., spins cars, takes actions toys apart).",
    "Does certain things repetitiverly, ritualistically.",
    "Engages in stereotyped behaviours when playing with toys or obejcts.",
    "Repeats unintelligible sounds (babbles) over and over.",
    "Shows unusual interest in sensory aspects of play materials, body parts, or objects.",
    "Displays ritualistic or compulsive behaviors.",
  ],
  "Social Interaction": [
    "Does not initiate converstions with peers or others.",
    "Pays little or no attention to what peers are doing.",
    "Fails to imitate other people in games or learning activities.",
    "Does not follow others gestures(cues) to look at something (e.g., when other person nods head, points, or use other language cues.)",
    "Seems indifferent to other persons attention (does not try to get, maintain, or direct the other persons attention.)",
    "Shows minimal expressed pleasure when interacting with others.",
    "Displays little or no excitement in showing toys or objects to others.",
    "Seems uninterested in pointing out things in the environment to others.",
    "Seems unwilling or reluctant to get others to interact with him or her.",
    "Shows minimal or no response when others attempt to interact with him or her.",
    "Displays little or no reciprocal social communication(e.g., deso not voluntarily say bye-bye in response to another saying bye-bye to him or her.",
    "Does not try to make frients with other people.",
    "Fails to engage in creative, imaginative play.",
    "Shows little or no interest in other people.",
  ],
  "Social Communication": [
    "Responds inappropriately to humorous stimuli(e.g., does not laugh at jokes, cartoons, funny stories).",
    "Has difficulty understanding jokes.",
    "Has difficulty understanding slang expressions.",
    "Has difficulty identifying when someone is teasing.",
    "Has difficulty understanding when he or she is being ridiculed.",
    "Has difficulty understanding what causes people to dislike him or her.",
    "Fails to predict probable consequences in social events.",
    "Does not seem to understand that people have thoughts and feeelings different from hisor hers.",
    "Does not seem to understand that the other person does not know something.",
  ],
  "Emotional Responses": [
    "Needs an excessive amount of reassurance if things are changed or go wrong.",
    "Becomes frustrated quickly when he or she cannot do something.",
    "Temper tantrums when frustrated.",
    "Becomes upset when routines are changed.",
    "Responds negatively when given commands, request, or directions,",
    "Has exterem reactions (e.g., cries, screams, tantrums) in response to loud, unexpected noise.",
    "Temper tantrums when does not get his or her way.",
    "Temper tantrums when told to stop doing something he or she enjoys doing.",
  ],
  "Congnitive Style": [
    "Uses exceptionally precise speech.",
    "Attaches very concrete meanings to words.",
    "Talks about a single subject excessively.",
    "Displays superior knowledge or skill in specific subjects.",
    "Displays excellent memory.",
    "Shows an intense, obsessive interest in specific intellectual subjects.",
    "Makes naïve remarks (unaware of reaction produced in others).",
  ],
  "Maladaptive Speech": [
    "Repeats (echoes) words or phrases verbally or with signs.",
    "Repeats words out of context ( repeats words or phrases heard at an earlier time).",
    "Speaks (or sign) with flat tone, affect.",
    "Uses yes and no inappropriately. Says yes when asked if he or she wants an aversive stimulus or says no when he or she want a favorite toy or treat.",
    "Uses he or she instead of I when referring to self.",
    "Speech is abnormal in tone, volumn, or rate.",
    "Utters idiosyncratic words or phrases that have no meaning to others.",
  ],
};

const Morning = [
  {
    "item": "Waking up routine",
    "subPreferencesItems": [
      "Difficulty waking up (delayed response to alarm, needing help).",
      "Early riser (wakes up extremely early, even without an alarm).",
      "Resistance to transitioning from sleep to wakefulness.",
      "Repetitive morning rituals (e.g., watching the same video, organizing objects).",
    ],
  },
  {
    "item": "Self-care habits",
    "subPreferencesItems": [
      "Requiring prompting or assistance with brushing teeth, dressing, etc.",
      "Sensitivity to certain textures of clothing.",
      "Preference for specific clothes or objects (e.g., only wears the same shirt).",
      "Difficulty tolerating grooming tasks (e.g., brushing hair, washing face).",
    ],
  },
  {
    "item": "Communication",
    "subPreferencesItems": [
      "Limited verbal communication in the morning.",
      "Repeating certain phrases or sounds.",
      "Difficulty transitioning to interactive communication.",
    ],
  },
  {
    "item": "Sensory sensitivities",
    "subPreferencesItems": [
      "Avoidance of bright lights or loud sounds in the morning.",
      "Engaging in sensory-stimulating behaviors like rocking, hand-flapping.",
    ],
  },
];

const Afternoon = [
  {
    "item": "Activity preferences",
    "subPreferencesItems": [
      "Focused, repetitive play (lining up objects, spinning toys).",
      "Engagement in solitary activities (e.g., puzzles, drawing).",
      "Specific interest in structured activities (e.g., video games, coding).",
      "Disinterest or avoidance of unstructured social interactions.",
    ]
  },
  {
    "item": "Eating routine",
    "subPreferencesItems": [
      "Selective eating (limited food preferences, may only eat familiar foods).",
      "Difficulty sitting still during meals.",
      "Sensitivity to textures or strong aversions to certain foods.",
    ],
  },
  {
    "item": "Transition challenges",
    "subPreferencesItems": [
      "Difficulty transitioning between activities (e.g., from schoolwork to play).",
      "Increased irritability if routines are disrupted.",
      "Using self-soothing behaviors (e.g., fidgeting, holding a preferred object).",
    ],
  },
];

const Evening = [
  {
    "item": "Wind-down routine",
    "subPreferencesItems": [
      "Rigid adherence to a specific routine before bed (e.g., watching the same show).",
      "Difficulty with transitions to quieter, calming activities.",
      "Avoiding dim or calming environments (prefers more stimulating environments).",
    ]
  },
  {
    "item": "Sensory behavior",
    "subPreferencesItems": [
      "Increased sensitivity to sensory input (e.g., irritability with noises, bright lights).",
      "Engaging in stimming (repetitive behaviors like hand-flapping, rocking).",
      "Seeking out sensory input (e.g., wrapping in blankets, listening to certain sounds).",
    ],
  },
  {
    "item": "Social engagement",
    "subPreferencesItems": [
      "Preference for solitary activities (e.g., drawing, using electronic devices).",
      "Avoidance of family/social gatherings or difficulty engaging in conversation.",
      "Difficulty understanding social cues when interacting with peers.",
    ],
  }, 
];

const Noon = [
  {
    "item": "Midday routines",
    "subPreferencesItems": [
      "Strict adherence to routine during lunch (same seat, specific food preferences).",
      "Engaging in solitary activities during break periods (e.g., walks, sensory toys).",
      "Difficulty with transitions back to work/school activities after lunch."
    ],
  },
  {
    "item": "Attention and focus",
    "subPreferencesItems": [
      "Difficulty maintaining focus on tasks, especially after lunch.",
      "Reliance on routines or visual schedules to remain organized.",
      "Engaging in special interests during free time (e.g., hyper-focusing on one subject).",
    ],
  },
  {
    "item": "Sensory challenges",
    "subPreferencesItems": [
      "Heightened sensitivity to the environment (e.g., avoiding crowded spaces).",
      "Increased use of sensory tools (e.g., noise-canceling headphones, fidget toys)."
      "Resistance to loud or overwhelming environments during lunchtime."
    ],
  },
];

const Night = [
  {
    "item": "Sleeping habits",
    "subPreferencesItems": [
      "Difficulty falling asleep (may stay awake for extended periods).",
      "Night awakenings (waking up in the middle of the night).",
      "Strict bedtime routines (needs to follow a set of steps before going to bed).",
      "Prefers sleeping in specific environments (e.g., very dark or very quiet rooms).",
    ],
  },
  {
    "item": "Sensory behavior",
    "subPreferencesItems": [
      "Use of weighted blankets or soft objects for comfort while sleeping.",
      "Sensitivity to temperature (e.g., needing the room to be a specific temperature).",
      "Repetitive bedtime rituals (repeatedly checking things, arranging pillows/toys).",
    ],
  },
  {
    "item": "Pre-bedtime activities",
    "subPreferencesItems": [
      "Engaging in calming, repetitive activities (e.g., listening to the same music, watching the same video).",
      "Difficulty winding down from stimulating activities.",
      "Use of stimming behaviors as a self-soothing mechanism.",
    ],
  },
];

const Burnouts = [
  {
    "item": "Increased Irritability", 
    "subPreferencesItems": [ 
      "Individuals may show signs of heightened frustration or anger when overwhelmed.",
    ],
  },
  {
    "item": "Withdrawal",
    "subPreferencesItems": [
      "Tendency to isolate themselves or refuse social interactions, preferring solitary activities.",
    ],
  },
  {
    "item":" Meltdowns", 
    "subPreferencesItems": [
      "Sudden outbursts of emotional distress, often resulting from sensory overload or social demands.",
    ],
  },
  {
    "item": "Physical Symptoms", 
    "subPreferencesItems": [
      "Complaints of fatigue, headaches, or stomachaches that seem to arise during stressful situations.",
    ],
  },
  {
    "item": "Inconsistent Routines", 
    "subPreferencesItems": [
      "Frequent changes in daily schedules or environments that disrupt established routines.",
    ],
  },
  {
    "item": "Sensory Overload", 
    "subPreferencesItems": [
      "Exposure to loud noises, bright lights, or crowded spaces that may lead to overwhelming experiences.",
    ],
  },
  {
    "item": "Social Demands", 
    "subPreferencesItems": [
      "Increased pressure to engage in social activities, such as school events or family gatherings, leading to exhaustion.",
    ],
  },
  {
    "item": "Academic Pressure",
    "subPreferencesItems": [
      "Difficulties in school settings, including struggles with learning or performance expectations.",
    ],
  },
];

const Events = [
  {
    "item": "Overreactive Responses", 
    "subPreferencesItems": [
      "Intense reactions to significant events (e.g., family gatherings, birthday parties) that may cause distress.",
    ],
  },
  {
    "item": "Inability to Process Change", 
    "subPreferencesItems": [
      "Difficulty adapting to changes, such as moving to a new school or changes in family dynamics.",
    ],
  },
  {
    "item": "Obsessive Focus ", 
    "subPreferencesItems": [
      "Fixation on certain topics or events, leading to challenges in shifting attention to other areas.",
    ],
  },
  {
    "item": "Difficulty with Time Management", 
    "subPreferencesItems": [
      "Struggles to plan or anticipate upcoming events, often leading to anxiety.",
    ],
  },
  {
    "item": "Traumatic Events", 
    "subPreferencesItems": [
      "Experiences of trauma, such as loss or separation, that may trigger anxiety or behavioral changes.",
    ],
  },
  {
    "item": "Social Gatherings", 
    "subPreferencesItems": [
      "Repeated instances of feeling overwhelmed during social interactions or public events.",
    ],
  },
  {
    "item": "Transitions",
    "subPreferencesItems": [
      "History of transitioning between schools or homes that may have led to increased anxiety and stress.",
    ],
  },
];
 
const Retentions = [
  { 
    "item": "Difficulty Recalling Information", 
    "subPreferencesItems": [
      "Challenges in remembering specific facts, events, or routines despite having learned them previously.",
    ],
  },
  {
    "item": "Repetitive Questions", 
    "subPreferencesItems": [
      "Tendency to ask the same questions repeatedly, indicating difficulty retaining answers.",
    ],
  },
  {
    "item": "Struggles with New Learning", 
    "subPreferencesItems": [
      "Difficulty applying previously learned skills or knowledge in new situations.",
    ],
  },
  {
    "item": "Rigid Routines", 
    "subPreferencesItems": [
      "Preference for strict adherence to routines, making it hard to adapt when changes occur.",
    ],
  },
  {
    "item": "Memory Challenges", 
    "subPreferencesItems": [
      "Reported difficulties in retaining information from school or daily activities, leading to frustration.",
    ],
  },
  {
    "item": "Limited Generalization of Skills", 
    "subPreferencesItems": [
      "Challenges in transferring learned skills from one context to another (e.g., using social skills in different settings).",
    ],
  },
  {
    "item": "Reinforcement of Specific Interests",
    "subPreferencesItems": [
      "Retention of information related to specific interests or obsessions while struggling with other areas.",
    ],
  },
  {
    "item": "Delayed Developmental Milestones",
    "subPreferencesItems": [
      "Historical context of delayed language or cognitive development that may impact memory retention.",
    ],
  },
];