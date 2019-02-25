namespace CastleDefenderPMG
{
    partial class Form1
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.pictureBox1 = new System.Windows.Forms.PictureBox();
            this.pictureBox2 = new System.Windows.Forms.PictureBox();
            this.buttonLoadImage = new System.Windows.Forms.Button();
            this.buttonLoadPMG = new System.Windows.Forms.Button();
            this.buttonSavePMG = new System.Windows.Forms.Button();
            this.openFileDialog1 = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog1 = new System.Windows.Forms.SaveFileDialog();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.buttonClearPMG = new System.Windows.Forms.Button();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).BeginInit();
            this.SuspendLayout();
            // 
            // pictureBox1
            // 
            this.pictureBox1.Location = new System.Drawing.Point(12, 40);
            this.pictureBox1.Name = "pictureBox1";
            this.pictureBox1.Size = new System.Drawing.Size(100, 50);
            this.pictureBox1.TabIndex = 0;
            this.pictureBox1.TabStop = false;
            this.pictureBox1.LoadCompleted += new System.ComponentModel.AsyncCompletedEventHandler(this.pictureBox1_LoadCompleted);
            // 
            // pictureBox2
            // 
            this.pictureBox2.Location = new System.Drawing.Point(118, 40);
            this.pictureBox2.Name = "pictureBox2";
            this.pictureBox2.Size = new System.Drawing.Size(100, 50);
            this.pictureBox2.TabIndex = 1;
            this.pictureBox2.TabStop = false;
            this.pictureBox2.MouseDown += new System.Windows.Forms.MouseEventHandler(this.pictureBox2_MouseDown);
            this.pictureBox2.MouseLeave += new System.EventHandler(this.pictureBox2_MouseLeave);
            this.pictureBox2.MouseMove += new System.Windows.Forms.MouseEventHandler(this.pictureBox2_MouseMove);
            this.pictureBox2.MouseUp += new System.Windows.Forms.MouseEventHandler(this.pictureBox2_MouseUp);
            // 
            // buttonLoadImage
            // 
            this.buttonLoadImage.Location = new System.Drawing.Point(12, 12);
            this.buttonLoadImage.Name = "buttonLoadImage";
            this.buttonLoadImage.Size = new System.Drawing.Size(75, 23);
            this.buttonLoadImage.TabIndex = 2;
            this.buttonLoadImage.Text = "Load image";
            this.buttonLoadImage.UseVisualStyleBackColor = true;
            this.buttonLoadImage.Click += new System.EventHandler(this.buttonLoadImage_Click);
            // 
            // buttonLoadPMG
            // 
            this.buttonLoadPMG.Location = new System.Drawing.Point(118, 12);
            this.buttonLoadPMG.Name = "buttonLoadPMG";
            this.buttonLoadPMG.Size = new System.Drawing.Size(75, 23);
            this.buttonLoadPMG.TabIndex = 3;
            this.buttonLoadPMG.Text = "Load PMG";
            this.buttonLoadPMG.UseVisualStyleBackColor = true;
            this.buttonLoadPMG.Click += new System.EventHandler(this.buttonLoadPMG_Click);
            // 
            // buttonSavePMG
            // 
            this.buttonSavePMG.Location = new System.Drawing.Point(199, 11);
            this.buttonSavePMG.Name = "buttonSavePMG";
            this.buttonSavePMG.Size = new System.Drawing.Size(75, 23);
            this.buttonSavePMG.TabIndex = 4;
            this.buttonSavePMG.Text = "Save PMG";
            this.buttonSavePMG.UseVisualStyleBackColor = true;
            this.buttonSavePMG.Click += new System.EventHandler(this.buttonSavePMG_Click);
            // 
            // openFileDialog1
            // 
            this.openFileDialog1.FileName = "openFileDialog1";
            // 
            // comboBox1
            // 
            this.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Items.AddRange(new object[] {
            "8",
            "4",
            "2",
            "1"});
            this.comboBox1.Location = new System.Drawing.Point(360, 11);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(42, 21);
            this.comboBox1.TabIndex = 5;
            this.comboBox1.SelectedIndexChanged += new System.EventHandler(this.comboBox1_SelectedIndexChanged);
            // 
            // buttonClearPMG
            // 
            this.buttonClearPMG.Location = new System.Drawing.Point(477, 9);
            this.buttonClearPMG.Name = "buttonClearPMG";
            this.buttonClearPMG.Size = new System.Drawing.Size(75, 23);
            this.buttonClearPMG.TabIndex = 6;
            this.buttonClearPMG.Text = "Clear PMG";
            this.buttonClearPMG.UseVisualStyleBackColor = true;
            this.buttonClearPMG.Click += new System.EventHandler(this.buttonClearPMG_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.buttonClearPMG);
            this.Controls.Add(this.comboBox1);
            this.Controls.Add(this.buttonSavePMG);
            this.Controls.Add(this.buttonLoadPMG);
            this.Controls.Add(this.buttonLoadImage);
            this.Controls.Add(this.pictureBox2);
            this.Controls.Add(this.pictureBox1);
            this.Name = "Form1";
            this.Text = "CastleDefenderPMG (MatoSimi 2019)";
            this.Load += new System.EventHandler(this.Form1_Load);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox1)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox2)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.PictureBox pictureBox1;
        private System.Windows.Forms.PictureBox pictureBox2;
        private System.Windows.Forms.Button buttonLoadImage;
        private System.Windows.Forms.Button buttonLoadPMG;
        private System.Windows.Forms.Button buttonSavePMG;
        private System.Windows.Forms.OpenFileDialog openFileDialog1;
        private System.Windows.Forms.SaveFileDialog saveFileDialog1;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.Button buttonClearPMG;
    }
}

