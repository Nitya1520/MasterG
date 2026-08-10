
import os
import sys
import django

# Get the project root directory
BASE_DIR = os.path.dirname(
    os.path.dirname(os.path.abspath(__file__))
)

# Add project root to Python path
sys.path.insert(0, BASE_DIR)

# Tell Django where settings.py is
os.environ.setdefault(
    "DJANGO_SETTINGS_MODULE",
    "api.settings"
)

# Initialize Django
django.setup()

# Import models
from vocabulary.models import Vocabulary, VocabularySentence
import os
import django

# --------------------------------------------------
# Django setup
# --------------------------------------------------

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "api.settings")
django.setup()


# --------------------------------------------------
# Import models AFTER django.setup()
# --------------------------------------------------

from vocabulary.models import Vocabulary, VocabularySentence


# --------------------------------------------------
# Vocabulary data
# --------------------------------------------------

SEED_VOCABULARY = {
    "A1": [
        {
            "word": "Ambitious",
            "pronunciation": "am-bi-shus",
            "gujarati_meaning": "મહત્વાકાંક્ષી",
            "english_meaning": "Having a strong desire to succeed.",
            "sentences": [
                "She is ambitious and wants to become a doctor.",
                "My friend is ambitious about his career.",
                "Ambitious students study every day.",
                "He is ambitious and hardworking.",
                "She has ambitious goals for the future."
            ]
        },
        {
            "word": "Curious",
            "pronunciation": "kyoo-ree-uhs",
            "gujarati_meaning": "જિજ્ઞાસુ / ઉત્સુક",
            "english_meaning": "Eager to know or learn something.",
            "sentences": [
                "The boy was curious about how the machine works.",
                "She gave me a curious look.",
                "Curious kids ask a lot of questions.",
                "I am curious to see what happens next.",
                "Scientists are curious by nature."
            ]
        },
        {
        "word": "Brave",
        "pronunciation": "brayv",
        "gujarati_meaning": "બહાદુર",
        "english_meaning": "Having courage and not being afraid.",
        "sentences": [
            "He is a brave boy.",
            "The brave firefighter saved the child.",
            "She was brave during the difficult time.",
            "Brave people help others.",
            "The brave soldier protected his country."
        ]
    },
    {
        "word": "Friendly",
        "pronunciation": "frend-lee",
        "gujarati_meaning": "મૈત્રીપૂર્ણ / મૈત્રીભાવવાળું",
        "english_meaning": "Kind and pleasant toward other people.",
        "sentences": [
            "My new teacher is very friendly.",
            "She is friendly to everyone.",
            "The dog is friendly.",
            "He has a friendly smile.",
            "Friendly people are easy to talk to."
        ]
    },
    {
        "word": "Honest",
        "pronunciation": "on-ist",
        "gujarati_meaning": "પ્રામાણિક / ઈમાનદાર",
        "english_meaning": "Always telling the truth.",
        "sentences": [
            "He is an honest person.",
            "She is honest with her parents.",
            "Honest people are trusted by others.",
            "My friend gave me an honest answer.",
            "It is important to be honest."
        ]
    },
    {
        "word": "Happy",
        "pronunciation": "hap-ee",
        "gujarati_meaning": "ખુશ",
        "english_meaning": "Feeling good, pleased, or joyful.",
        "sentences": [
            "I am happy today.",
            "She looks very happy.",
            "The children are happy to play outside.",
            "He was happy with his results.",
            "We are happy to see you."
        ]
    },
    {
        "word": "Helpful",
        "pronunciation": "help-ful",
        "gujarati_meaning": "મદદરૂપ",
        "english_meaning": "Willing to help someone.",
        "sentences": [
            "My teacher is very helpful.",
            "She gave me helpful advice.",
            "He is always helpful to his friends.",
            "This book is helpful for beginners.",
            "Thank you for being so helpful."
        ]
    },
    {
        "word": "Careful",
        "pronunciation": "kair-ful",
        "gujarati_meaning": "સાવચેત",
        "english_meaning": "Giving attention to avoid mistakes or danger.",
        "sentences": [
            "Be careful when you cross the road.",
            "She is careful with her money.",
            "He is careful while driving.",
            "Be careful with the glass.",
            "Careful students check their work."
        ]
    },
    {
        "word": "Kind",
        "pronunciation": "kynd",
        "gujarati_meaning": "દયાળુ",
        "english_meaning": "Being nice and caring toward others.",
        "sentences": [
            "She is a kind person.",
            "He is kind to animals.",
            "My teacher is very kind.",
            "Kind people help others.",
            "It was kind of you to help me."
        ]
    },
    {
        "word": "Polite",
        "pronunciation": "puh-lite",
        "gujarati_meaning": "વિનમ્ર / શિષ્ટ",
        "english_meaning": "Having good manners and showing respect.",
        "sentences": [
            "He is always polite to his teachers.",
            "She is a polite girl.",
            "Please be polite to everyone.",
            "The waiter was very polite.",
            "Polite children say please and thank you."
        ]
    },
    {
        "word": "Lazy",
        "pronunciation": "lay-zee",
        "gujarati_meaning": "આળસુ",
        "english_meaning": "Not wanting to work or make an effort.",
        "sentences": [
            "He is too lazy to clean his room.",
            "I feel lazy today.",
            "Lazy students do not study regularly.",
            "The cat is lazy in the afternoon.",
            "Don't be lazy; finish your homework."
        ]
    },
    {
        "word": "Strong",
        "pronunciation": "strong",
        "gujarati_meaning": "મજબૂત",
        "english_meaning": "Having physical or mental power.",
        "sentences": [
            "He is very strong.",
            "She has strong hands.",
            "Exercise helps you become strong.",
            "The strong man lifted the box.",
            "You need to be strong during difficult times."
        ]
    },
        {
            "word": "Delightful",
            "pronunciation": "dih-lahyt-fuhl",
            "gujarati_meaning": "આનંદદાયક",
            "english_meaning": "Causing great pleasure or delight.",
            "sentences": [
                "We had a delightful evening with our friends.",
                "This garden is a delightful place to read.",
                "The cake was absolutely delightful.",
                "It was delightful to meet you.",
                "She told a delightful story."
            ]
        },
        {
            "word": "Efficient",
            "pronunciation": "ih-fish-uhnt",
            "gujarati_meaning": "કાર્યક્ષમ",
            "english_meaning": "Achieving maximum productivity with minimum wasted effort.",
            "sentences": [
                "An efficient assistant saves a lot of time.",
                "We need to find a more efficient way to work.",
                "The new heating system is very efficient.",
                "He is highly efficient at handling complaints.",
                "Fluorescent lamps are very efficient."
            ]
        },
        {
            "word": "Generous",
            "pronunciation": "jen-er-uhs",
            "gujarati_meaning": "ઉદાર",
            "english_meaning": "Showing a readiness to give more of something than is necessary.",
            "sentences": [
                "It was very generous of you to pay for dinner.",
                "She is always generous with her praise.",
                "He made a generous donation to the charity.",
                "A generous portion of soup was served.",
                "They are generous hosts."
            ]
        }
    ],
    "A2": [
        {
            "word": "Adventure",
            "pronunciation": "ad-ven-cher",
            "gujarati_meaning": "સાહસ",
            "english_meaning": "An unusual and exciting or daring experience.",
            "sentences": [
                "Traveling in the mountains was a great adventure.",
                "They went on an adventure into the deep forest.",
                "I love reading stories about wilderness adventures.",
                "She is looking for a new job adventure.",
                "Adventure travel is growing in popularity."
            ]
        },
        {
        "word": "Improve",
        "pronunciation": "im-proov",
        "gujarati_meaning": "સુધારવું",
        "english_meaning": "To make something better.",
        "sentences": [
            "I want to improve my English.",
            "She is trying to improve her writing.",
            "Practice can improve your skills.",
            "He improved his grades this year.",
            "We need to improve our communication."
        ]
    },
    {
        "word": "Experience",
        "pronunciation": "ik-speer-ee-uhns",
        "gujarati_meaning": "અનુભવ",
        "english_meaning": "Knowledge or skill gained from doing something.",
        "sentences": [
            "I had a great experience at the new school.",
            "She has experience working with children.",
            "Travel gives you new experiences.",
            "He gained valuable experience from his job.",
            "This was an exciting experience for me."
        ]
    },
    {
        "word": "Discover",
        "pronunciation": "dis-kuv-er",
        "gujarati_meaning": "શોધવું / શોધી કાઢવું",
        "english_meaning": "To find something for the first time.",
        "sentences": [
            "We discovered a beautiful place.",
            "She wants to discover new cultures.",
            "I discovered an interesting book.",
            "They discovered a small village.",
            "You can discover many things while traveling."
        ]
    },
    {
        "word": "Decide",
        "pronunciation": "di-syd",
        "gujarati_meaning": "નક્કી કરવું",
        "english_meaning": "To choose something after thinking about it.",
        "sentences": [
            "I need to decide what to do.",
            "She decided to study abroad.",
            "We decided to go by train.",
            "He cannot decide which shirt to buy.",
            "They decided to start a new project."
        ]
    },
    {
        "word": "Prepare",
        "pronunciation": "pri-pair",
        "gujarati_meaning": "તૈયાર કરવું",
        "english_meaning": "To get ready for something.",
        "sentences": [
            "I need to prepare for my exam.",
            "She prepared dinner for her family.",
            "He is preparing for the interview.",
            "We prepared everything before the trip.",
            "Students should prepare well for tests."
        ]
    },
    {
        "word": "Popular",
        "pronunciation": "pop-yuh-ler",
        "gujarati_meaning": "લોકપ્રિય",
        "english_meaning": "Liked or enjoyed by many people.",
        "sentences": [
            "This restaurant is very popular.",
            "Football is popular around the world.",
            "She is a popular teacher at school.",
            "That song became popular quickly.",
            "This place is popular with tourists."
        ]
    },
    {
        "word": "Comfortable",
        "pronunciation": "kumf-ter-bul",
        "gujarati_meaning": "આરામદાયક",
        "english_meaning": "Feeling relaxed and physically at ease.",
        "sentences": [
            "This chair is very comfortable.",
            "I feel comfortable in my new home.",
            "She wore comfortable clothes.",
            "The hotel room was clean and comfortable.",
            "Make yourself comfortable."
        ]
    },
    {
        "word": "Necessary",
        "pronunciation": "nes-uh-ser-ee",
        "gujarati_meaning": "જરૂરી",
        "english_meaning": "Needed for a particular purpose.",
        "sentences": [
            "Water is necessary for life.",
            "It is necessary to study every day.",
            "A passport is necessary for international travel.",
            "Sleep is necessary for good health.",
            "Is it necessary to bring a laptop?"
        ]
    },
    {
        "word": "Different",
        "pronunciation": "dif-er-uhnt",
        "gujarati_meaning": "અલગ / જુદું",
        "english_meaning": "Not the same as someone or something else.",
        "sentences": [
            "We have different opinions.",
            "This book is different from that one.",
            "Everyone has different interests.",
            "She tried a different restaurant.",
            "My new job is very different from my old one."
        ]
    },
    {
        "word": "Possible",
        "pronunciation": "pos-uh-bul",
        "gujarati_meaning": "શક્ય",
        "english_meaning": "Able to happen or be done.",
        "sentences": [
            "Is it possible to finish this today?",
            "Anything is possible with hard work.",
            "It is possible to learn English quickly.",
            "We will arrive as soon as possible.",
            "Is it possible to change the date?"
        ]
    },
        {
            "word": "Comfortable",
            "pronunciation": "kuhm-fter-buhl",
            "gujarati_meaning": "આરામદાયક",
            "english_meaning": "Providing physical ease and relaxation.",
            "sentences": [
                "This sofa is very comfortable.",
                "Are you comfortable in that chair?",
                "We had a comfortable flight.",
                "He lives a comfortable life in the suburbs.",
                "Wear comfortable shoes for walking."
            ]
        }
    ],
    "B1": [
        {
            "word": "Eloquent",
            "pronunciation": "el-uh-kwuhnt",
            "gujarati_meaning": "સુવક્તા",
            "english_meaning": "Fluent or persuasive in speaking or writing.",
            "sentences": [
                "She gave an eloquent speech at the ceremony.",
                "His writing style is highly eloquent.",
                "An eloquent argument convinced the jury.",
                "He was eloquent in his defense of the environment.",
                "Her eyes were more eloquent than words."
            ]
        },
        {
        "word": "Confident",
        "pronunciation": "kon-fi-duhnt",
        "gujarati_meaning": "આત્મવિશ્વાસુ",
        "english_meaning": "Feeling sure about your abilities or decisions.",
        "sentences": [
            "She feels confident about her English skills.",
            "He was confident before the interview.",
            "Practice helps you become more confident.",
            "She gave a confident answer.",
            "I am confident that we can finish the project."
        ]
    },
    {
        "word": "Responsible",
        "pronunciation": "ri-spon-suh-bul",
        "gujarati_meaning": "જવાબદાર",
        "english_meaning": "Having a duty to take care of something or someone.",
        "sentences": [
            "She is responsible for managing the team.",
            "He is a responsible employee.",
            "Parents are responsible for their children.",
            "You should be responsible for your actions.",
            "She is responsible and always finishes her work."
        ]
    },
    {
        "word": "Opportunity",
        "pronunciation": "op-er-too-nuh-tee",
        "gujarati_meaning": "તક",
        "english_meaning": "A good chance to do or achieve something.",
        "sentences": [
            "This job is a great opportunity.",
            "She got an opportunity to study abroad.",
            "Don't miss this opportunity.",
            "The course provides many opportunities to learn.",
            "He is looking for a new opportunity."
        ]
    },
    {
        "word": "Challenge",
        "pronunciation": "chal-inj",
        "gujarati_meaning": "પડકાર",
        "english_meaning": "Something that is difficult and requires effort.",
        "sentences": [
            "Learning a new language can be a challenge.",
            "The project was a big challenge.",
            "She enjoys challenging herself.",
            "We faced many challenges during the journey.",
            "This job offers new challenges every day."
        ]
    },
    {
        "word": "Influence",
        "pronunciation": "in-floo-uhns",
        "gujarati_meaning": "પ્રભાવ",
        "english_meaning": "The power to affect someone's thoughts, actions, or decisions.",
        "sentences": [
            "Friends can influence our decisions.",
            "His teacher had a strong influence on him.",
            "Social media influences young people.",
            "Parents have a big influence on their children.",
            "Music can influence our mood."
        ]
    },
    {
        "word": "Achieve",
        "pronunciation": "uh-cheev",
        "gujarati_meaning": "હાંસલ કરવું",
        "english_meaning": "To successfully reach a goal or result.",
        "sentences": [
            "She worked hard to achieve her goals.",
            "He achieved a high score in the exam.",
            "You can achieve anything with practice.",
            "They achieved great success.",
            "I want to achieve my career goals."
        ]
    },
    {
        "word": "Require",
        "pronunciation": "ri-kwyr",
        "gujarati_meaning": "જરૂર હોવી / જરૂરી હોવું",
        "english_meaning": "To need something for a particular purpose.",
        "sentences": [
            "This job requires good communication skills.",
            "The course requires regular practice.",
            "You are required to bring your ID.",
            "The project requires more time.",
            "Learning a language requires patience."
        ]
    },
    {
        "word": "Effective",
        "pronunciation": "ih-fek-tiv",
        "gujarati_meaning": "અસરકારક",
        "english_meaning": "Successful in producing the desired result.",
        "sentences": [
            "This is an effective way to learn English.",
            "The new method was very effective.",
            "Exercise is an effective way to stay healthy.",
            "She found an effective solution to the problem.",
            "Good communication is an effective way to avoid mistakes."
        ]
    },
    {
        "word": "Communicate",
        "pronunciation": "kuh-myoo-ni-kayt",
        "gujarati_meaning": "વાતચીત કરવી / સંદેશાવ્યવહાર કરવો",
        "english_meaning": "To share information, ideas, or feelings with someone.",
        "sentences": [
            "It is important to communicate clearly.",
            "She communicates well with her team.",
            "We use English to communicate with people around the world.",
            "He found it difficult to communicate his feelings.",
            "Good leaders communicate with their employees."
        ]
    },
    {
        "word": "Independent",
        "pronunciation": "in-di-pen-duhnt",
        "gujarati_meaning": "સ્વતંત્ર",
        "english_meaning": "Able to do things without depending on others.",
        "sentences": [
            "She is an independent young woman.",
            "He became independent after getting a job.",
            "Students should learn to be independent.",
            "Living alone helped him become more independent.",
            "She is independent and makes her own decisions."
        ]
    }
    ],
    "B2": [
        {
            "word": "Pragmatic",
            "pronunciation": "prag-mat-ik",
            "gujarati_meaning": "વ્યવહારિક",
            "english_meaning": "Dealing with things realistically based on practical considerations.",
            "sentences": [
                "We need a pragmatic solution to this traffic issue.",
                "He took a pragmatic approach to the dispute.",
                "She is very pragmatic about career choices.",
                "Let's be pragmatic and look at the cost.",
                "Pragmatic business decisions help save money."
            ]
        },
         {
        "word": "Significant",
        "pronunciation": "sig-nif-i-kuhnt",
        "gujarati_meaning": "નોંધપાત્ર / મહત્વપૂર્ણ",
        "english_meaning": "Important or large enough to have an effect.",
        "sentences": [
            "The company made a significant investment in technology.",
            "There has been a significant improvement in his English.",
            "This discovery could have a significant impact on society.",
            "She played a significant role in the project.",
            "The changes had a significant effect on our results."
        ]
    },
    {
        "word": "Efficient",
        "pronunciation": "ih-fish-uhnt",
        "gujarati_meaning": "કાર્યક્ષમ",
        "english_meaning": "Working well without wasting time, energy, or resources.",
        "sentences": [
            "We need a more efficient way to manage our time.",
            "The new system is more efficient than the old one.",
            "She is an efficient employee.",
            "Using technology can make the process more efficient.",
            "An efficient team can complete the work quickly."
        ]
    },
    {
        "word": "Reliable",
        "pronunciation": "ri-lie-uh-bul",
        "gujarati_meaning": "વિશ્વસનીય",
        "english_meaning": "Able to be trusted to work well or behave as expected.",
        "sentences": [
            "We need a reliable internet connection.",
            "He is a reliable person who always keeps his promises.",
            "This car is very reliable.",
            "She is one of our most reliable employees.",
            "It is important to use reliable information."
        ]
    },
    {
        "word": "Flexible",
        "pronunciation": "flek-suh-bul",
        "gujarati_meaning": "લવચીક",
        "english_meaning": "Able to change or adapt easily to different situations.",
        "sentences": [
            "My company offers flexible working hours.",
            "You need to be flexible when plans change.",
            "She has a flexible approach to problem-solving.",
            "The schedule is flexible and can be changed.",
            "Flexible employees can adapt to new situations."
        ]
    },
    {
        "word": "Accurate",
        "pronunciation": "ak-yuh-rit",
        "gujarati_meaning": "ચોક્કસ / સચોટ",
        "english_meaning": "Correct and free from mistakes.",
        "sentences": [
            "Please make sure the information is accurate.",
            "The report contains accurate data.",
            "His answer was accurate.",
            "We need accurate information before making a decision.",
            "The machine provides accurate results."
        ]
    },
    {
        "word": "Considerable",
        "pronunciation": "kuhn-sid-er-uh-bul",
        "gujarati_meaning": "નોંધપાત્ર / ઘણું",
        "english_meaning": "Large or important enough to be noticed.",
        "sentences": [
            "The project requires a considerable amount of time.",
            "She has made considerable progress in English.",
            "The company experienced considerable growth.",
            "He spent a considerable amount of money on the house.",
            "There was considerable interest in the new product."
        ]
    },
    {
        "word": "Persuasive",
        "pronunciation": "per-sway-siv",
        "gujarati_meaning": "પ્રભાવશાળી / મનાવનાર",
        "english_meaning": "Good at convincing someone to believe or do something.",
        "sentences": [
            "She gave a persuasive argument.",
            "His speech was very persuasive.",
            "A persuasive advertisement can influence customers.",
            "He is a persuasive speaker.",
            "She used persuasive language to convince the team."
        ]
    },
    {
        "word": "Controversial",
        "pronunciation": "kon-truh-vur-shul",
        "gujarati_meaning": "વિવાદાસ્પદ",
        "english_meaning": "Causing disagreement or strong differences of opinion.",
        "sentences": [
            "The decision was highly controversial.",
            "He made a controversial statement.",
            "The new law has become controversial.",
            "The film discusses a controversial topic.",
            "His controversial ideas attracted a lot of attention."
        ]
    },
    {
        "word": "Relevant",
        "pronunciation": "rel-uh-vuhnt",
        "gujarati_meaning": "સંબંધિત / પ્રસ્તુત",
        "english_meaning": "Directly connected with or useful to a particular subject.",
        "sentences": [
            "Please provide relevant information.",
            "His experience is relevant to this job.",
            "The teacher asked relevant questions.",
            "We need to focus on the most relevant issues.",
            "This example is relevant to our discussion."
        ]
    },
    {
        "word": "Potential",
        "pronunciation": "puh-ten-shul",
        "gujarati_meaning": "સંભવિત / ક્ષમતા",
        "english_meaning": "Having the possibility of developing or becoming something.",
        "sentences": [
            "She has great potential as a leader.",
            "This project has the potential to succeed.",
            "We should consider the potential risks.",
            "The company is looking for potential customers.",
            "He showed great potential at a young age."
        ]
    }
    ],
    "C1": [
        {
            "word": "Mitigate",
            "pronunciation": "mit-i-geyt",
            "gujarati_meaning": "નરમ કરવું / ઓછું કરવું",
            "english_meaning": "Make something bad less severe, serious, or painful.",
            "sentences": [
                "The government took steps to mitigate the flood damage.",
                "Planting trees helps mitigate climate impact.",
                "We can mitigate the risk by testing early.",
                "Medicine was given to mitigate the pain.",
                "Actions were taken to mitigate loss of data."
            ]
        },
        {
        "word": "Substantial",
        "pronunciation": "suhb-stan-shul",
        "gujarati_meaning": "નોંધપાત્ર / મોટું",
        "english_meaning": "Large in amount, value, or importance.",
        "sentences": [
            "The company made a substantial investment in technology.",
            "She has made substantial progress in her studies.",
            "The project requires a substantial amount of funding.",
            "There was a substantial increase in demand.",
            "He received substantial support from his team."
        ]
    },
    {
        "word": "Coherent",
        "pronunciation": "koh-heer-uhnt",
        "gujarati_meaning": "સુસંગત / તાર્કિક",
        "english_meaning": "Logical, clear, and well organized.",
        "sentences": [
            "She gave a coherent explanation of the problem.",
            "His argument was clear and coherent.",
            "The report presents a coherent view of the situation.",
            "Try to write a coherent paragraph.",
            "He struggled to give a coherent response."
        ]
    },
    {
        "word": "Ambiguous",
        "pronunciation": "am-big-yoo-uhs",
        "gujarati_meaning": "અસ્પષ્ટ / દ્વિઅર્થી",
        "english_meaning": "Having more than one possible meaning or interpretation.",
        "sentences": [
            "The instructions were too ambiguous.",
            "His answer was ambiguous and difficult to understand.",
            "The law contains some ambiguous language.",
            "Her statement was deliberately ambiguous.",
            "The message was ambiguous, so nobody knew what he meant."
        ]
    },
    {
        "word": "Inevitable",
        "pronunciation": "in-ev-i-tuh-bul",
        "gujarati_meaning": "અનિવાર્ય",
        "english_meaning": "Certain to happen and impossible to avoid.",
        "sentences": [
            "Change is inevitable in modern society.",
            "Some mistakes are inevitable when learning.",
            "The team knew that defeat was inevitable.",
            "Technological development is inevitable.",
            "It became inevitable that they would need more time."
        ]
    },
    {
        "word": "Compelling",
        "pronunciation": "kuhm-pel-ing",
        "gujarati_meaning": "આકર્ષક / убедક",
        "english_meaning": "Very convincing or interesting and difficult to ignore.",
        "sentences": [
            "She presented a compelling argument.",
            "The documentary tells a compelling story.",
            "There is compelling evidence against the theory.",
            "His speech was both powerful and compelling.",
            "The book provides a compelling explanation of the issue."
        ]
    },
    {
        "word": "Conventional",
        "pronunciation": "kuhn-ven-shuh-nul",
        "gujarati_meaning": "પરંપરાગત / રૂઢિચુસ્ત",
        "english_meaning": "Based on traditional or generally accepted ideas or methods.",
        "sentences": [
            "They rejected the conventional approach to education.",
            "She prefers conventional methods of teaching.",
            "The company uses conventional marketing techniques.",
            "His views are quite different from conventional thinking.",
            "Conventional medicine is not always the only option."
        ]
    },
    {
        "word": "Deteriorate",
        "pronunciation": "di-teer-ee-uh-rayt",
        "gujarati_meaning": "બગડવું / કથળવું",
        "english_meaning": "To become worse in condition or quality.",
        "sentences": [
            "The patient's condition began to deteriorate.",
            "The roads have deteriorated over the years.",
            "Their relationship started to deteriorate.",
            "The situation could deteriorate quickly.",
            "The quality of the service has deteriorated recently."
        ]
    },
    {
        "word": "Facilitate",
        "pronunciation": "fuh-sil-i-tayt",
        "gujarati_meaning": "સરળ બનાવવું / સુગમ બનાવવું",
        "english_meaning": "To make an action or process easier.",
        "sentences": [
            "Technology can facilitate communication.",
            "The new system will facilitate faster payments.",
            "The teacher used activities to facilitate learning.",
            "These tools facilitate collaboration between teams.",
            "The meeting was organized to facilitate discussion."
        ]
    },
    {
        "word": "Resilient",
        "pronunciation": "ri-zil-ee-uhnt",
        "gujarati_meaning": "સ્થિતિસ્થાપક / મુશ્કેલીમાંથી ઝડપથી ઉભરનાર",
        "english_meaning": "Able to recover quickly from difficulties or problems.",
        "sentences": [
            "She is remarkably resilient after facing many challenges.",
            "Children can be surprisingly resilient.",
            "The company remained resilient during the economic crisis.",
            "A resilient person learns from failure.",
            "The community proved to be highly resilient."
        ]
    },
    {
        "word": "Scrutinize",
        "pronunciation": "skroo-tuh-nyz",
        "gujarati_meaning": "ઝીણવટથી તપાસવું",
        "english_meaning": "To examine something very carefully and in detail.",
        "sentences": [
            "The committee will scrutinize the proposal.",
            "Investors carefully scrutinized the company's financial report.",
            "The police scrutinized the evidence.",
            "You should scrutinize the contract before signing it.",
            "The journalist scrutinized every detail of the story."
        ]
    }
    ],
    "C2": [
        {
            "word": "Superfluous",
            "pronunciation": "soo-pur-floo-uhs",
            "gujarati_meaning": "વધારાનું / બિનજરૂરી",
            "english_meaning": "Unnecessary, especially through being more than enough.",
            "sentences": [
                "Please delete any superfluous words in your essay.",
                "Superfluous packaging is bad for the environment.",
                "We have all the data we need; more is superfluous.",
                "He avoided superfluous details in the report.",
                "Superfluous spendings should be cut down."
            ]
        },
        {
        "word": "Ubiquitous",
        "pronunciation": "yoo-bik-wi-tuhs",
        "gujarati_meaning": "સર્વવ્યાપક / સર્વત્ર જોવા મળતું",
        "english_meaning": "Present, appearing, or found everywhere.",
        "sentences": [
            "Smartphones have become ubiquitous in modern society.",
            "Social media is ubiquitous among young people.",
            "The ubiquitous presence of technology has changed our lives.",
            "Coffee shops are ubiquitous in large cities.",
            "Advertising is ubiquitous on the internet."
        ]
    },
    {
        "word": "Meticulous",
        "pronunciation": "muh-tik-yuh-luhs",
        "gujarati_meaning": "ઝીણવટભર્યું / ખૂબ કાળજીપૂર્વકનું",
        "english_meaning": "Showing great attention to detail and accuracy.",
        "sentences": [
            "She is meticulous about her work.",
            "The scientist conducted a meticulous analysis.",
            "He is known for his meticulous attention to detail.",
            "The report was prepared with meticulous care.",
            "Her meticulous planning helped the project succeed."
        ]
    },
    {
        "word": "Pragmatic",
        "pronunciation": "prag-mat-ik",
        "gujarati_meaning": "વ્યવહારિક",
        "english_meaning": "Dealing with problems in a practical and realistic way.",
        "sentences": [
            "We need a pragmatic solution to the problem.",
            "She took a pragmatic approach to the situation.",
            "His pragmatic attitude helped the team make a decision.",
            "They adopted a pragmatic strategy.",
            "A pragmatic leader focuses on practical results."
        ]
    },
    {
        "word": "Incongruous",
        "pronunciation": "in-kong-groo-uhs",
        "gujarati_meaning": "વિસંગત / અસંગત",
        "english_meaning": "Not suitable or consistent with its surroundings or situation.",
        "sentences": [
            "His casual clothes looked incongruous at the formal event.",
            "The modern building seemed incongruous in the historic area.",
            "Her cheerful response was incongruous with the serious situation.",
            "The bright colors appeared incongruous in the dark room.",
            "His behavior was completely incongruous with his position."
        ]
    },
    {
        "word": "Plausible",
        "pronunciation": "plaw-zuh-bul",
        "gujarati_meaning": "વિશ્વસનીય લાગતું / સંભવિત",
        "english_meaning": "Seeming reasonable or likely to be true.",
        "sentences": [
            "She gave a plausible explanation for her absence.",
            "His theory sounds plausible.",
            "There are several plausible reasons for the failure.",
            "The explanation was plausible but not proven.",
            "Scientists are considering several plausible possibilities."
        ]
    },
    {
        "word": "Ambivalent",
        "pronunciation": "am-biv-uh-luhnt",
        "gujarati_meaning": "દ્વિધાગ્રસ્ત / મિશ્ર લાગણીઓ ધરાવતું",
        "english_meaning": "Having mixed or uncertain feelings about something.",
        "sentences": [
            "She felt ambivalent about moving to another city.",
            "He remains ambivalent about the decision.",
            "I am ambivalent about accepting the offer.",
            "The public was ambivalent toward the new policy.",
            "She had ambivalent feelings about leaving her job."
        ]
    },
    {
        "word": "Perpetuate",
        "pronunciation": "per-pet-yoo-ayt",
        "gujarati_meaning": "ચાલુ રાખવું / કાયમી બનાવવું",
        "english_meaning": "To cause something to continue for a long time.",
        "sentences": [
            "The policy may perpetuate existing inequalities.",
            "These stories can perpetuate harmful stereotypes.",
            "We should not perpetuate outdated ideas.",
            "The system continues to perpetuate social divisions.",
            "His actions helped perpetuate the problem."
        ]
    },
    {
        "word": "Inadvertently",
        "pronunciation": "in-uh-vur-tuhnt-lee",
        "gujarati_meaning": "અજાણતાં / અનાયાસે",
        "english_meaning": "Without intending to do something.",
        "sentences": [
            "He inadvertently revealed the confidential information.",
            "She inadvertently deleted the important file.",
            "I inadvertently offended him with my comment.",
            "The article inadvertently created confusion.",
            "He inadvertently caused a delay in the project."
        ]
    },
    {
        "word": "Conundrum",
        "pronunciation": "kuh-nun-drum",
        "gujarati_meaning": "મૂંઝવણભરી સમસ્યા / કોયડો",
        "english_meaning": "A difficult problem or situation that is hard to solve.",
        "sentences": [
            "The company faces a difficult financial conundrum.",
            "Finding a solution to the problem was a real conundrum.",
            "The decision created a conundrum for the government.",
            "She was faced with the conundrum of choosing between two careers.",
            "The ethical conundrum has no simple answer."
        ]
    },
    {
        "word": "Exacerbate",
        "pronunciation": "ig-zas-ur-bayt",
        "gujarati_meaning": "વધુ ખરાબ બનાવવું",
        "english_meaning": "To make a problem or situation worse.",
        "sentences": [
            "The lack of communication exacerbated the problem.",
            "Heavy traffic can exacerbate air pollution.",
            "His comments only exacerbated the conflict.",
            "Poor planning may exacerbate the situation.",
            "The economic crisis exacerbated existing social problems."
        ]
    }
    ]
}
# --------------------------------------------------
# Insert data into database
# --------------------------------------------------

def seed_vocabulary():

    total_words = 0
    total_sentences = 0

    for level, words in SEED_VOCABULARY.items():

        print(f"\nProcessing {level}...")

        for word_no, data in enumerate(words, start=1):

            # Create or update vocabulary
            vocabulary, created = Vocabulary.objects.update_or_create(
                level=level,
                word_no=word_no,
                defaults={
                    "word": data["word"],
                    "pronunciation": data["pronunciation"],
                    "gujarati_meaning": data["gujarati_meaning"],
                    "english_meaning": data["english_meaning"],
                }
            )

            # Remove old sentences
            vocabulary.sentences.all().delete()

            # Add new sentences
            for sentence in data["sentences"]:

                VocabularySentence.objects.create(
                    vocabulary=vocabulary,
                    sentence=sentence
                )

                total_sentences += 1

            total_words += 1

            if created:
                print(
                    f"  CREATED: {level} #{word_no} - {data['word']}"
                )
            else:
                print(
                    f"  UPDATED: {level} #{word_no} - {data['word']}"
                )

    print("\n-----------------------------------")
    print("Vocabulary seeding completed!")
    print(f"Total words: {total_words}")
    print(f"Total sentences: {total_sentences}")
    print("-----------------------------------")


# --------------------------------------------------
# Run automatically when script.py is executed
# --------------------------------------------------

if __name__ == "__main__":
    seed_vocabulary()